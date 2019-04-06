# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # SearchQuery関係
  module SearchQuery
    def search_queries
      EncapsulationSearchQuery.search_queries
    end
  end

  # SearchQuery関係の実装
  module EncapsulationSearchQuery
    CREATED_AGO = 8.days.ago

    module_function

    # rubocop:disable Metrics/MethodLength
    # rubocop:disable Metrics/LineLength
    def search_queries
      [
        { words: [],              nwords: ['Python'], threshold: 100, created_ago: CREATED_AGO },
        { words: ['VSCode'],      nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['React'],       nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['TypeScript'],  nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['JavaScript'],  nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['Git'],         nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['nginx'],       nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['CentOS'],      nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['Chrome'],      nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['Rails'],       nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['RubyOnRails'], nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['GitHub'],      nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['Ruby'],        nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['Linux'],       nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['AWS'],         nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['MySQL'],       nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['Scala'],       nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['Zsh'],         nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['Ubuntu'],      nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO },
        { words: ['kubernetes'],  nwords: ['Python'], threshold: 10,  created_ago: CREATED_AGO }
      ]
    end
    # rubocop:enable Metrics/MethodLength
    # rubocop:enable Metrics/LineLength
  end
end
