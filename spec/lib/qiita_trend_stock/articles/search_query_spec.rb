# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../lib/qiita_trend_stock/articles/search_query'

module QiitaTrendStock
  RSpec.describe SearchQuery do
    let(:test_target_class) do
      Class.new { include SearchQuery }
    end

    # qiitaにリクエストする文字列なんで適当
    # ログを見ればおかしい事はすぐ判ると思うからテストは適当
    context '#search_queries' do
      it '配列を返してくる' do
        expect(test_target_class.new.search_queries).to be_an_instance_of(Array)
      end
    end
  end
end
