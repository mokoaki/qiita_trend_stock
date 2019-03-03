# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # includeされたトコに定数を作るよ たぶんこの辺りがconcernを使うんだと思う
  module Client
    def self.included(klass)
      klass.const_set(:QiitaClient, EncapsulationClient.client)
    end

    # 上記の実装
    module EncapsulationClient
      module_function

      def client
        ::Qiita::Client.new(access_token: access_token)
      end

      def access_token
        ENV['QIITA_ACCESS_TOKEN']
      end
    end
  end
end
