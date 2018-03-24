# frozen_string_literal: true

require_relative 'qiita_trend_stock/main'

QiitaTrendStock.start(
  qiita_access_token:  ENV['QIITA_ACCESS_TOKEN'],
  stocked_item_uuid:   ENV['STOCKED_ITEM_UUID'],
  stock_keep_deadline: 8.days.ago
)
