# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/qiita_trend_stock/search_queries'

module QiitaTrendStock
  RSpec.describe SearchQueries do
    let(:test_target_class) do
      Class.new { include SearchQueries }
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
