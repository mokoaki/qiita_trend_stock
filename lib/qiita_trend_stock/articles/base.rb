# frozen_string_literal: true

require_relative './search_query'
require_relative './fetch'
require_relative './stock'
require_relative './user_status'

# namespase
module QiitaTrendStock
  # ほぼすべての機能はここに集まる
  class Articles
    include SearchQuery
    include Fetch
    include Stock
    include UserStatus

    def initialize
      @fetched_articles = []
      @stocked_articles = []
    end
  end
end
