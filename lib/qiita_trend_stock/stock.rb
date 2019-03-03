# frozen_string_literal: true

# require_relative './qiita_article'

# 全ての機能を含む
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  class QiitaArticles
    def stock!
      @stocked_articles = @fetched_articles.map(&:stock!).compact
    end

    def stocked_uuids
      @stocked_articles.map(&:uuid)
    end
  end
end
