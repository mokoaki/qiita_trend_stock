# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # Fetch関係
  module Fetch
    def fetch!
      @fetched_articles = EncapsulationFetch.fetch!(search_queries)
    end
  end

  # Fetch関係の実装
  module EncapsulationFetch
    module_function

    def fetch!(search_queries)
      articles = search_queries.flat_map do |query|
        Interface.fetch!(query)
      end

      # 異なる条件で同じエントリーが見つかっていたならユニークにする
      articles.uniq(&:uuid)
    end
  end
end
