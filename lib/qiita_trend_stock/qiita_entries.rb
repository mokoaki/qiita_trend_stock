# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  class QiitaEntries
    def initialize
      @entry_items = []
      @stocked_items = []
    end
  end
end
