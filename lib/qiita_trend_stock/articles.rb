# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  class Articles
    include SearchQueries
    include UserStatus
    include Fetch
    include Stock

    def initialize
      @fetched_articles = []
      @stocked_articles = []
    end
  end
end
