# frozen_string_literal: true

require 'open-uri'

module QiitaTrendStock
  # Qiitaトレンド入りしているアイテムを取ってくる・保持するクラス
  class TrendItems < Items
    undef :uuids

    def fetch(qiita_client)
      trend_item_uuids = qiita_trend_item_uuids(qiita_client)
      @items           = self_items(trend_item_uuids)
    end

    private

    def qiita_trend_item_uuids(qiita_client)
      first_items = qiita_list_item(qiita_client, 1)

      match_last_page = first_items.last_page_url.match(/page=(\d+)/)[1].to_i

      results = first_items.body.map { |item| item['id'] }

      (2..match_last_page).each do |page|
        items = qiita_list_item(qiita_client, page)
        results.concat(items.body.map { |item| item['id'] })
      end

      results.map(&:presence).compact.uniq
    end

    def qiita_list_item(qiita_client, page)
      limit_date = 7.days.ago.strftime('%F')
      query      = "stocks:>20 created:>#{limit_date}"
      qiita_client.list_items(page: page, per_page: 100, query: query)
    end

    def self_items(trend_item_uuids)
      trend_item_uuids.map { |uuid| Item.new(uuid: uuid) }
    end
  end
end
