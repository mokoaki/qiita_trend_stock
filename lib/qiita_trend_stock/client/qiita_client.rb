# frozen_string_literal: true

# namespace
module QiitaTrendStock
  # Clientが定義されている事を確定するためだけ
  class Client
  end

  # Qiita-GemのFacadeであり
  # Clientを使ったtemplate-methodだと思ってるけどあんまり自信ないっす
  class QiitaClient < Client
    class << self
      def query_articles(page, query)
        EncapsulationQiitaClient.query_articles(page, query)
      end

      def stock_item(uuid)
        EncapsulationQiitaClient.stock_item(uuid)
      end

      def user_status
        EncapsulationQiitaClient.user_status
      end

      # ・・の実装
      module EncapsulationQiitaClient
        module_function

        def query_articles(page, query)
          client.list_items(page: page, per_page: 100, query: query)
        end

        def stock_item(uuid)
          responce_body = client.stock_item(uuid).body

          # stock成功時はbodyはnilらしい
          return true if responce_body.nil?

          responce_message = responce_message(responce_body)

          # stock済みは「stockしなかった」のfalseを返す
          return false if responce_message == 'Already stocked'

          # エラー時は適当に出力して正常に終了したかの如く処理を続ける
          p '=' * 100
          p "stock_item(#{uuid}) Error"
          p responce_body

          false
        end

        def responce_message(responce_body)
          responce_body['message']
        rescue StandardError
          responce_body
        end

        def user_status
          auth_headers = client.get_authenticated_user.headers
          allow_keys = %w[Rate-Limit Rate-Remaining Rate-Reset X-Runtime Date]
          result_headers = auth_headers.slice(*allow_keys)
          result_headers['DateJST'] = Time.zone.parse(result_headers['Date']).to_s
          result_headers
        end

        def client
          @client ||= ::Qiita::Client.new(access_token: access_token)
        end

        def access_token
          ENV['QIITA_ACCESS_TOKEN']
        end
      end
    end
  end
end
