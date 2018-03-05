# frozen_string_literal: true

require 'bundler/setup'
require 'active_support'
require 'active_support/core_ext'
require 'qiita'
require 'open-uri'

trend_json  = open('https://qiita.com/trend.json').read
trend_data  = JSON.parse(trend_json)
trend_items = trend_data['trendItems']
uuids       = trend_items.map { |item| item.dig('article', 'uuid') }.compact

qiita_client = Qiita::Client.new(access_token: ENV['qiita_access_token'])

uuids.each do |uuid|
  qiita_client.stock_item(uuid)
end

auth_headers      = qiita_client.get_authenticated_user.headers
result_allow_keys = %w[Date Rate-Limit Rate-Remaining Rate-Reset X-Runtime]
result_headers    = auth_headers.slice(*result_allow_keys)

Time.zone = 'Asia/Tokyo'

p Time.zone.parse(result_headers['Date']).to_s
pp result_headers
pp uuids
p '( ｰ`дｰ´) おｋ'
