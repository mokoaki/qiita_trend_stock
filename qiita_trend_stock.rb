# frozen_string_literal: true

require_relative 'qiita_trend_stock/main'

QiitaTrendStock::Main.start(
  qiita_trend_uri:    'https://qiita.com/trend.json',
  qiita_access_token: ENV['qiita_access_token'],
  stocked_item_uuid:  ENV['stocked_item_uuid']
)
