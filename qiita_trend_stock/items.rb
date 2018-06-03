# frozen_string_literal: true

module QiitaTrendStock
  # Items管理クラス達の共通処理だよ
  class Items
    def initialize
      @items = []
    end
  end

  module Behaviors
    # Itemsを継承したクラスが必要としたりしなかったりする簡単な処理
    module Uuids
      def uuids
        @uuids ||= @items.map(&:uuid).map(&:presence).compact
      end
    end

    # Itemsを継承したクラスが必要としたりしなかったりする簡単な処理
    module Items
      def items
        @items.uniq(&:uuid)
      end
    end
  end
end
