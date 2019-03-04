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
      results = interface_fetch(search_queries)

      # 異なる条件で同じエントリーが見つかっていたならユニークにする
      results.flatten.uniq(&:uuid)
    end

    def interface_fetch(search_queries)
      search_queries.map do |query|
        Interface.fetch!(query)
      end
    end
  end
end
