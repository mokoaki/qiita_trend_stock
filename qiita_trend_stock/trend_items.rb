# frozen_string_literal: true

module QiitaTrendStock
  # Qiitaトレンド入りしているアイテムを取ってくる・保持するクラス
  # 初期は https://qiita.com/trend.json から取得していたが
  # https://github.com/mokoaki/qiita_trend_stock/blob/4332449e4af4133ac6facfed8b417ff8609dbe81/qiita_trend_stock/trend_items.rb
  # なんかアクセス出来なくなったので
  # API経由で取得しようとしたらいいね数でソートしたデータ受け取れねえし(´；ω；｀)
  # しょうがねえなと思いながらAPI検索を我慢して使う
  class TrendItems < Items
    undef :uuids

    def fetch(qiita_client, query)
      trend_item_uuids = qiita_trend_item_uuids(qiita_client, query)
      items            = self_items(trend_item_uuids)

      @items.concat(items)
    end

    private

    def qiita_trend_item_uuids(qiita_client, query)
      trend_pages = qiita_trend_pages(qiita_client, query)
      uuids       = qiita_page_uuids(trend_pages)

      uuids.map(&:presence).compact.uniq
    end

    def qiita_trend_pages(qiita_client, query)
      # 読んでも10ページまで
      (1..10).each_with_object([]) do |page, trend_pages|
        trend_page = qiita_trend_page(qiita_client, page, query)
        trend_pages << trend_page

        break trend_pages if trend_page.next_page_url.blank?
      end
    end

    def qiita_trend_page(qiita_client, page, query)
      qiita_client.list_items(page: page, per_page: 100, query: query)
    end

    def qiita_page_uuids(trend_pages)
      trend_pages.inject([]) do |uuids, page|
        uuids.concat(page.body.map { |item| item['id'] })
      end
    end

    def self_items(trend_item_uuids)
      trend_item_uuids.map do |uuid|
        Item.new(uuid: uuid)
      end
    end
  end
end
