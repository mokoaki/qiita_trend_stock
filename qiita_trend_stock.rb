# frozen_string_literal: true

require 'bundler/setup'
require 'active_support'
require 'active_support/core_ext'
require 'qiita'
require 'open-uri'

Time.zone = 'Asia/Tokyo'

def qiita_trend_uri
  'https://qiita.com/trend.json'
end

def qiita_trend_json
  Kernel.open(qiita_trend_uri).read
end

def qiita_trend_items
  JSON.parse(qiita_trend_json)['trendItems']
end

def qiita_trend_uuids
  qiita_trend_items.map { |item| item.dig('article', 'uuid').presence }.compact
end

def qiita_access_token
  ENV['qiita_access_token']
end

def qiita_client
  @qiita_client ||= Qiita::Client.new(access_token: qiita_access_token)
end

def stocked_item_uuid
  ENV['stocked_item_uuid']
end

def stocked_item
  qiita_client.get_item(stocked_item_uuid)
end

def stocked_item_json
  stocked_item.body['body']
end

def stocked_item_data
  @stocked_item_data ||= JSON.parse(stocked_item_json)
end

def stocked_uuids
  stocked_item_data.keys.map(&:presence).compact
end

def new_trend_item_uuids
  @new_trend_item_uuids ||= (qiita_trend_uuids - stocked_uuids)
end

def new_trend_item_stock
  new_trend_item_uuids.each do |uuid|
    qiita_client.stock_item(uuid)
  end
end

def new_stocked_item_data
  new_trend_item_uuids.each_with_object({}) do |uuid, result|
    result[uuid] = Time.zone.now.to_s
  end
end

def new_stocked_item_json
  new_stocked_item_data.merge(stocked_item_data).to_json
end

def formatted_json
  [
    [/\A\{/, %({\n)],
    [/\}\z/, %(\n})],
    [%(","), %(",\n")]
  ].inject(new_stocked_item_json) do |result, (from, to)|
    result.gsub(from, to)
  end
end

def save_stocked_uuids
  qiita_client.update_item(
    stocked_item_uuid,
    body: formatted_json,
    title: 'stocked_qiita_trend'
  )
end

def print_log
  auth_headers      = qiita_client.get_authenticated_user.headers
  result_allow_keys = %w[Date Rate-Limit Rate-Remaining Rate-Reset X-Runtime]
  result_headers    = auth_headers.slice(*result_allow_keys)

  p Time.zone.parse(result_headers['Date']).to_s
  pp result_headers
  pp new_trend_item_uuids
  p '( ｰ`дｰ´) おｋ'
end

new_trend_item_stock
save_stocked_uuids
print_log
