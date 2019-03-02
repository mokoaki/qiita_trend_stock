# frozen_string_literal: true

require_relative 'entry_items'

# 全ての機能を含む
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  class EntryItems
    def fetch!
      self.entry_items = FetchImplement.fetch_entry_items(qiita_search_queries)
    end

    # fetch系の実装
    module FetchImplement
      module_function

      def fetch_entry_items(qiita_search_queries)
        entry_items = qiita_search_queries.flat_map do |query|
          entry_items_query(query)
        end

        # 異なる条件で同じエントリーが見つかっていたならユニークにする
        entry_items.uniq(&:uuid)
      end

      # rubocop:disable Metrics/MethodLength
      def entry_items_query(query)
        result_entry_items = []

        # 読んでも10ページまで
        (1..10).each do |page|
          query_responce = entry_items_page_query(page, query)
          entries = query_responce.body
          entry_items = build_entry_items(entries)
          result_entry_items.concat(entry_items)

          p "Query [page: #{page}] [#{query}] [count: #{entry_items.size}]"

          break if entries.empty?
          break if query_responce.next_page_url.blank?
        end

        result_entry_items
      end
      # rubocop:enable Metrics/MethodLength

      def entry_items_page_query(page, query)
        QIITA_CLIENT.list_items(page: page, per_page: 100, query: query)
      end

      def build_entry_items(entries)
        entries.map do |entry|
          # 必要なものはエントリーのユニークIDのみ
          uuid = entry['id']
          EntryItem.new(uuid)
        end
      end
    end
  end
end
