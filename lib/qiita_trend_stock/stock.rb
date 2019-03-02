# frozen_string_literal: true

require_relative 'entry_items'

# 全ての機能を含む
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  class EntryItems
    def stock!
      self.stocked_items = entry_items.map(&:stock!).compact
    end

    def stocked_uuids
      stocked_items.map(&:uuid)
    end
  end
end
