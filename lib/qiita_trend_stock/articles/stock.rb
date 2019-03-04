# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # Stock関係
  module Stock
    def stock!
      @stocked_articles = EncapsulationStock.stock!(@fetched_articles)
    end

    def stocked_uuids
      EncapsulationStockedUuids.stocked_uuids(@stocked_articles)
    end
  end

  # Stock関係の実装
  module EncapsulationStock
    module_function

    def stock!(target_articles)
      stocked_articles = articles_stock!(target_articles)
      compact_articles(stocked_articles)
    end

    def articles_stock!(target_articles)
      target_articles.map(&:stock!)
    end

    def compact_articles(target_articles)
      target_articles.compact
    end
  end

  # 上記の実装
  module EncapsulationStockedUuids
    module_function

    def stocked_uuids(target_articles)
      stocked_item_uuids = stocked_item_uuids(target_articles)
      uniq_uuids(stocked_item_uuids)
    end

    def stocked_item_uuids(target_articles)
      target_articles.map(&:uuid)
    end

    def uniq_uuids(target_uuids)
      target_uuids.uniq
    end
  end
end
