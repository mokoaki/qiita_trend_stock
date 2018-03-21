# frozen_string_literal: true

require 'bundler/setup'
require 'active_support'
require 'active_support/core_ext'
require 'qiita'

Time.zone = 'Asia/Tokyo'

require_relative 'item'
require_relative 'items'
require_relative 'trend_items'
require_relative 'stocked_items'
require_relative 'new_trend_items'
require_relative 'new_stocked_items'

module QiitaTrendStock
  module Main
    class << self
      def start(qiita_trend_uri:, qiita_access_token:, stocked_item_uuid:)
        trend_items = TrendItems.new
        trend_items.fetch(qiita_trend_uri)

        qiita_client = ::Qiita::Client.new(access_token: qiita_access_token)

        stocked_items = StockedItems.new
        stocked_items.fetch(qiita_client, stocked_item_uuid)

        new_trend_items = NewTrendItems.new
        new_trend_items.find(trend_items, stocked_items)
        new_trend_items.items_stock!(qiita_client)

        new_stocked_items = NewStockedItems.new
        new_stocked_items.concat(new_trend_items)
        new_stocked_items.concat(stocked_items)
        new_stocked_items.delete_old_items!(1.month.ago)
        new_stocked_items.store_stocked_uuids!(qiita_client, stocked_item_uuid)

        output_log(qiita_client, new_trend_items)
      end

      def output_log(qiita_client, new_trend_items)
        auth_headers      = qiita_client.get_authenticated_user.headers
        result_allow_keys = %w[Date Rate-Limit Rate-Remaining Rate-Reset X-Runtime]
        result_headers    = auth_headers.slice(*result_allow_keys)

        p Time.zone.parse(result_headers['Date']).to_s
        pp result_headers
        pp new_trend_items.uuids
        p '( ｰ`дｰ´) おｋ'
      end
    end
  end
end
