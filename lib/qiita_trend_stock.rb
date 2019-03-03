# frozen_string_literal: true

# lib_directory_path = File.expand_path('./qiita_trend_stock', __dir__)
# $LOAD_PATH.unshift(lib_directory_path)

require_relative 'qiita_trend_stock/client'
require_relative 'qiita_trend_stock/search_queries'
require_relative 'qiita_trend_stock/user_status'

require_relative 'qiita_trend_stock/fetch'
require_relative 'qiita_trend_stock/stock'

require_relative 'qiita_trend_stock/article'
require_relative 'qiita_trend_stock/articles'
