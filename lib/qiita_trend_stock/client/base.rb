# frozen_string_literal: true

require_relative './qiita_client'

# 全ての機能を含む
module QiitaTrendStock
  # あーなんて書こう
  class Client
    class << self
      prepend QiitaClient
      # prepend XxxxxClient

      abstract_methods = [:query_articles, :stock_item, :user_status]

      abstract_methods.each do |abstract_method|
        define_method(abstract_method) do
          raise QiitaTrendStockClientImpleError
        end
        # あれ？respondあたりも実装するんじゃなかったっけ？
      end
    end
  end
end
