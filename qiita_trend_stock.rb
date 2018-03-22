# frozen_string_literal: true

require_relative 'qiita_trend_stock/main'

QiitaTrendStock::Main.start(
  stocked_item_uuid: ENV['STOCKED_ITEM_UUID']
)
