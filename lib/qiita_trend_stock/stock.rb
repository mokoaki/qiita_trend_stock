# frozen_string_literal: true

require_relative './qiita_entry'

# 全ての機能を含む
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  class QiitaEntries
    def stock!
      self.stocked_items = entry_items.map(&:stock!).compact
    end

    def stocked_uuids
      stocked_items.map(&:uuid)
    end
  end
end
