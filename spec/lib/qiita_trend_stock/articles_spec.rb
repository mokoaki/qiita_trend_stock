# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/qiita_trend_stock/articles'

module QiitaTrendStock
  RSpec.describe Articles do
    let(:articles) { Articles.new }

    context '#initialize' do
      it 'コンストラクタは[@fetched_articles,@stocked_articles]を空配列で初期化する' do
        expect(articles.instance_variable_get(:@fetched_articles)).to eq([])
        expect(articles.instance_variable_get(:@stocked_articles)).to eq([])
      end
    end
  end
end
