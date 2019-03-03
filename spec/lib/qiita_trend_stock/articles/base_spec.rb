# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../lib/qiita_trend_stock/articles/base'

RSpec.describe QiitaTrendStock::Articles do
  let(:articles) do
    described_class.new
  end

  context '#initialize' do
    it 'コンストラクタは[@fetched_articles,@stocked_articles]を空配列で初期化する' do
      expect(articles.instance_variable_get(:@fetched_articles)).to eq([])
      expect(articles.instance_variable_get(:@stocked_articles)).to eq([])
    end
  end
end
