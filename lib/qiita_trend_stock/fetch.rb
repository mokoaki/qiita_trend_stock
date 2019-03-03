# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  module Fetch
    def fetch!
      @fetched_articles = FetchImplement.fetch_articles(search_queries)
    end

    # fetch系の実装
    module FetchImplement
      module_function

      def fetch_articles(search_queries)
        articles = search_queries.flat_map do |query|
          articles_query(query)
        end

        # 異なる条件で同じエントリーが見つかっていたならユニークにする
        articles.uniq(&:uuid)
      end

      # rubocop:disable Metrics/MethodLength
      def articles_query(query)
        result_articles = []

        # 読んでも10ページまで
        (1..10).each do |page|
          query_responce = articles_page_query(page, query)
          responce_articles = query_responce.body
          articles = build_articles(responce_articles)
          result_articles.concat(articles)

          p "Query [page: #{page}] [#{query}] [count: #{articles.size}]"

          break if responce_articles.empty?
          break if query_responce.next_page_url.blank?
        end

        result_articles
      end
      # rubocop:enable Metrics/MethodLength

      def articles_page_query(page, query)
        Client.list_items(page: page, per_page: 100, query: query)
      end

      def build_articles(articles)
        articles.map do |article|
          # 必要なものはエントリーのユニークIDのみ
          uuid = article['id']
          Article.new(uuid)
        end
      end
    end
  end
end
