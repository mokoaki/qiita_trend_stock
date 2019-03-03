# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../lib/qiita_trend_stock/articles/stock'

module QiitaTrendStock
  RSpec.describe Stock do
    let(:test_target_class) do
      Class.new { include Stock }
    end

    let(:test_article1) { double(:test_article1) }
    let(:test_article2) { double(:test_article2) }
    let(:test_articles) { [test_article1, test_article2] }

    context '#stock!' do
      it 'articlesに保存されているitems_collectionそれぞれの#stock!メソッドを呼び出す' do
        expect(test_article1).to receive(:stock!) { test_article1 }
        expect(test_article2).to receive(:stock!) { test_article2 }
        articles = test_target_class.new
        articles.instance_variable_set(:@fetched_articles, test_articles)
        articles.stock!
      end
    end

    context '#stocked_uuids' do
      let(:uuid1) { 'uuid1' }
      let(:uuid2) { 'uuid2' }
      let(:uuids) { [uuid1, uuid2] }

      it 'stocked_itemsに保存されているitems_collectionそれぞれの#uuidを返す' do
        expect(test_article1).to receive(:uuid) { uuid1 }
        expect(test_article2).to receive(:uuid) { uuid2 }
        articles = test_target_class.new
        articles.instance_variable_set(:@stocked_articles, test_articles)
        expect(articles.stocked_uuids).to eq(uuids)
      end
    end
  end
end
