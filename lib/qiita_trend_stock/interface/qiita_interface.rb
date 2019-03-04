# frozen_string_literal: true

# namespace
module QiitaTrendStock
  # Interfaceが定義されている事を確定するためだけ
  class Interface
  end

  # Qiita-GemのFacadeであり
  # Interfaceを使ったtemplate-methodだと思ってるけどあんまり自信ないっす
  class QiitaInterface < Interface
    class << self
      def query_articles(page, query)
        EncapsulationQiitaInterface.query_articles(page, query)
      end

      def stock_item(uuid)
        EncapsulationQiitaInterface.stock_item(uuid)
      end

      def user_status
        EncapsulationQiitaInterface.user_status
      end
    end

    # ・・の実装
    module EncapsulationQiitaInterface
      module_function

      def query_articles(page, query)
        interface.list_items(page: page, per_page: 100, query: query)
      end

      def stock_item(uuid)
        responce_body = interface.stock_item(uuid).body

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

      def user_status
        auth_headers = interface.get_authenticated_user.headers
        allow_keys = %w[Rate-Limit Rate-Remaining Rate-Reset X-Runtime Date]
        result_headers = auth_headers.slice(*allow_keys)
        jst_string = Time.zone.parse(result_headers['Date']).to_s
        result_headers['DateJST'] = jst_string
        result_headers
      end

      def interface
        @interface ||= ::Qiita::Client.new(access_token: access_token)
      end

      def access_token
        ENV['QIITA_ACCESS_TOKEN']
      end
    end
  end
end
