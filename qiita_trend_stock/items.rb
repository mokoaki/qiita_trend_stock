# frozen_string_literal: true

module QiitaTrendStock
  # Items管理クラス達の共通処理だよ
  module Items
    def initialize
      @items = []
    end

    def uuids
      @uuids ||= @items.map(&:uuid).map(&:presence).compact
    end

    def items
      @items.uniq(&:uuid)
    end
  end
end
