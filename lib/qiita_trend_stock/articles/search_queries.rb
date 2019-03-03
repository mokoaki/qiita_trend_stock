# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  module SearchQueries
    def search_queries
      QiitaSearchQueriesImplement.target_queries
    end
  end

  # search_queries関係はこの中にカプセル化してある
  module QiitaSearchQueriesImplement
    module_function

    # rubocop:disable Metrics/AbcSize
    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Layout/SpaceInsideParens
    def target_queries
      result_queries = []
      result_queries << build_query(                    stocks_gt: 100)
      result_queries << build_query(tag: 'VSCode',      stocks_gt: 10)
      result_queries << build_query(tag: 'React',       stocks_gt: 10)
      result_queries << build_query(tag: 'TypeScript',  stocks_gt: 10)
      result_queries << build_query(tag: 'JavaScript',  stocks_gt: 10)
      result_queries << build_query(tag: 'Git',         stocks_gt: 10)
      result_queries << build_query(tag: 'nginx',       stocks_gt: 10)
      result_queries << build_query(tag: 'CentOS',      stocks_gt: 10)
      result_queries << build_query(tag: 'Chrome',      stocks_gt: 10)
      result_queries << build_query(tag: 'Rails',       stocks_gt: 10)
      result_queries << build_query(tag: 'RubyOnRails', stocks_gt: 10)
      result_queries << build_query(tag: 'GitHub',      stocks_gt: 10)
      result_queries << build_query(tag: 'Ruby',        stocks_gt: 10)
      result_queries << build_query(tag: 'Linux',       stocks_gt: 10)
      result_queries << build_query(tag: 'AWS',         stocks_gt: 10)
      result_queries << build_query(tag: 'MySQL',       stocks_gt: 10)
      result_queries << build_query(tag: 'Scala',       stocks_gt: 10)
      result_queries << build_query(tag: 'Zsh',         stocks_gt: 10)
      result_queries << build_query(tag: 'Ubuntu',      stocks_gt: 10)

      result_queries

      # [build_query(tag: 'Python', ntag: 'hage', stocks_gt: 210)]
    end
    # rubocop:enable Metrics/AbcSize
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Layout/SpaceInsideParens

    STOCK_KEEP_DEADLINE = 8.days.ago.strftime('%F')

    def build_query(tag: nil, ntag: nil, stocks_gt: nil, created_gt: nil)
      ntag       ||= 'Python'
      stocks_gt  ||= 100
      created_gt ||= STOCK_KEEP_DEADLINE

      result = []
      result << "tag:#{tag}"   if tag.present?
      result << "-tag:#{ntag}" if ntag.present?
      result << "stocks:>#{stocks_gt}"
      result << "created:>#{created_gt}"

      result.join(' ')
    end
  end
end
