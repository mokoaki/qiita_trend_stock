# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/qiita_trend_stock/qiita_search_queries'

module QiitaTrendStock
  RSpec.describe QiitaEntries do
    let(:entry_items) { QiitaEntries.new }

    # qiitaにリクエストする文字列なんで適当
    # ログを見ればおかしい事はすぐ判ると思うからテストは適当
    context '#qiita_search_queries' do
      it '配列を返してくる' do
        expect(entry_items.qiita_search_queries).to be_an_instance_of(Array)
      end
    end
  end
end
