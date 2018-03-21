# frozen_string_literal: true

module QiitaTrendStock
  # Items管理クラス達の共通処理だよ
  class Items
    attr_reader :items

    def initialize
      @items = []
    end

    def uuids
      @uuids ||= @items.map(&:uuid).map(&:presence).compact
    end
  end
end
