# frozen_string_literal: true

require 'singleton'
require_relative './qiita_interface'

# 全ての機能を含む
module QiitaTrendStock
  # 接続先/処理はこの辺のクラスで実装します
  # まぁQiita以外接続する予定はないけどtemplate-methodの勉強がてら
  class Interface
    # newして欲しくないな程度のsingleton
    include Singleton

    class << self
      abstract_methods = [:query_articles, :stock_item, :user_status]

      abstract_methods.each do |abstract_method|
        define_method(abstract_method) do |*args, &block|
          raise InterfaceAbstractMethodError, { args: args, block: block }.compact
        end
      end
    end
  end
end
