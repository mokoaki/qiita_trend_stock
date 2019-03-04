# frozen_string_literal: true

require 'singleton'
require_relative './qiita_interface'

# 全ての機能を含む
module QiitaTrendStock
  # 接続先/処理はこの辺のクラスで実装します
  class Interface
    # newして欲しくないな程度のsingleton
    include Singleton

    # 実装はこちら
    extend QiitaInterface
  end
end
