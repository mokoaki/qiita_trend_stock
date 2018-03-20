# frozen_string_literal: true

module QiitaTrendStock
  # トレンドから取得してきたアイテム、既にストックしたアイテムから
  # 新規のアイテム一覧を保持・ストックするクラス
  class NewTrendItems
    attr_reader :items

    def find(trend_items, stocked_items)
      found_trend_items = trend_items.items
      stocked_uuids     = stocked_items.uuids

      @items = found_trend_items.find_all do |item|
        stocked_uuids.exclude?(item.uuid)
      end
    end

    def uuids
      @uuids ||= @items.map(&:uuid).compact
    end

    def items_stock!(qiita_client)
      uuids.each do |uuid|
        qiita_client.stock_item(uuid)
      end
    end
  end
end
