# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  class EntryItems
    attr_accessor :entry_items
    attr_accessor :stocked_items

    def initialize
      self.entry_items = []
      self.stocked_items = []
    end
  end
end
