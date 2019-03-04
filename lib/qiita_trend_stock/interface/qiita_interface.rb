# frozen_string_literal: true

# namespace
module QiitaTrendStock
  # Qiita接続関係
  module QiitaInterface
    def fetch!(query)
      EncapsulationQiitaInterfaceQueryArticles.fetch!(query)
    end

    def stock_item(uuid)
      EncapsulationQiitaInterfaceStockItem.stock_item(uuid)
    end

    def user_status
      EncapsulationQiitaInterfaceUserStatus.user_status
    end

    # クライアント取得関係の実装
    module EncapsulationConnect
      module_function

      def interface
        @interface ||= ::Qiita::Client.new(access_token: access_token)
      end

      def access_token
        ENV['QIITA_ACCESS_TOKEN']
      end
    end

    # 記事取得関係の実装
    module EncapsulationQiitaInterfaceQueryArticles
      module_function

      # rubocop:disable Metrics/MethodLength
      def fetch!(query)
        qiita_query = build_query(query)
        result_articles = []

        # 読んでも3ページまで
        (1..3).each do |page|
          query_responce = query(page, qiita_query)
          responce_articles = query_responce.body
          articles = build_articles(responce_articles)
          result_articles.concat(articles)

          p "Query [page: #{page}] [#{qiita_query}] [count: #{articles.size}]"

          break if responce_articles.empty?
          break if query_responce.next_page_url.blank?
        end

        result_articles
      end
      # rubocop:enable Metrics/MethodLength

      # rubocop:disable Metrics/AbcSize
      def build_query(query)
        tags    = query[:words]
        ntags   = query[:nwords]
        stocks  = query[:threshold]
        created = query[:created_ago]

        result = []
        result << tags.map  { |w| "tag:#{w}" }         if tags.present?
        result << ntags.map { |w| "-tag:#{w}" }        if ntags.present?
        result << "stocks:>#{stocks}"                  if stocks.present?
        result << "created:>#{created.strftime('%F')}" if created.present?

        result.flatten.join(' ')
      end
      # rubocop:enable Metrics/AbcSize

      def query(page, query)
        EncapsulationConnect.interface.list_items(
          page: page,
          per_page: 100,
          query: query
        )
      end

      def build_articles(articles)
        articles.map do |article|
          # 必要なものはエントリーのユニークIDのみ
          uuid = article['id']
          Article.new(uuid)
        end
      end
    end

    # 記事ストック関係の実装
    module EncapsulationQiitaInterfaceStockItem
      module_function

      def stock_item(uuid)
        responce_body = EncapsulationConnect.interface.stock_item(uuid).body

        # stock成功時はbodyはnilらしい
        return true if responce_body.nil?

        responce_message = responce_message(responce_body)

        # stock済みは問題なし
        # 「stockしなかった」のfalseを返す
        return false if responce_message == 'Already stocked'

        # エラー時は適当に出力
        p '=' * 100
        p responce_body, uuid: uuid

        false
      end

      def responce_message(responce_body)
        responce_body['message']
      rescue StandardError
        responce_body
      end
    end

    # ステータス取得関係の実装
    module EncapsulationQiitaInterfaceUserStatus
      module_function

      def user_status
        auth_headers =
          EncapsulationConnect.interface.get_authenticated_user.headers
        allow_keys = %w[Rate-Limit Rate-Remaining Rate-Reset X-Runtime Date]
        result_headers = auth_headers.slice(*allow_keys)
        result_headers['DateJST'] =
          Time.zone.parse(result_headers['Date']).to_s
        result_headers
      end
    end
  end
end
