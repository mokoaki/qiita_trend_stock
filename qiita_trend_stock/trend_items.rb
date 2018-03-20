# frozen_string_literal: true

require 'open-uri'

module QiitaTrendStock
  # Qiitaトレンド入りしているアイテムを取ってくる・保持するクラス
  class TrendItems
    attr_reader :items

    def fetch(qiita_trend_uri)
      trend_item_json  = qiita_trend_item_json(qiita_trend_uri)
      trend_items      = qiita_trend_items(trend_item_json)
      trend_item_uuids = qiita_trend_item_uuids(trend_items)
      @items           = self_items(trend_item_uuids)
    end

    private

    def qiita_trend_item_json(qiita_trend_uri)
      Kernel.open(qiita_trend_uri).read
    end

    def qiita_trend_items(trend_item_json)
      JSON.parse(trend_item_json)['trendItems']
    end

    def qiita_trend_item_uuids(trend_items)
      trend_items.map { |item| item.dig('article', 'uuid').presence }.compact
    end

    def self_items(uuids)
      uuids.map { |uuid| Item.new(uuid: uuid) }
    end
  end
end
