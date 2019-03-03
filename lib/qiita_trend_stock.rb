# frozen_string_literal: true

# lib_directory_path = File.expand_path('./qiita_trend_stock', __dir__)
# $LOAD_PATH.unshift(lib_directory_path)

# このファイルをrequireすると全てが出来上がる、という算段

require_relative './errors'
require_relative './qiita_trend_stock/client/base'
require_relative './qiita_trend_stock/article/base'
require_relative './qiita_trend_stock/articles/base'
