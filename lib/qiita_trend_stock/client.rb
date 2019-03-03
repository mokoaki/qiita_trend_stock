# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # 定数の実装
  module EncapsulationQiitaClient
    module_function

    def client
      ::Qiita::Client.new(access_token: access_token)
    end

    def access_token
      ENV['QIITA_ACCESS_TOKEN']
    end
  end

  Client = EncapsulationQiitaClient.client
end
