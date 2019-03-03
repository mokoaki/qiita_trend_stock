# frozen_string_literal: true

require_relative './search_queries'
require_relative './fetch'
require_relative './stock'
require_relative './user_status'

# namespase
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  class Articles
    include SearchQueries
    include Fetch
    include Stock
    include UserStatus

    def initialize
      @fetched_articles = []
      @stocked_articles = []
    end
  end
end