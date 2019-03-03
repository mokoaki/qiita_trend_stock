# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/qiita_trend_stock/stock'

module QiitaTrendStock
  RSpec.describe QiitaArticles do
    let(:test_qiita_article1) { double(:test_qiita_article1) }
    let(:test_qiita_article2) { double(:test_qiita_article2) }
    let(:test_qiita_articles) { [test_qiita_article1, test_qiita_article2] }

    context '#stock!' do
      it 'articlesに保存されているitems_collectionそれぞれの#stock!メソッドを呼び出す' do
        expect(test_qiita_article1).to receive(:stock!) { test_qiita_article1 }
        expect(test_qiita_article2).to receive(:stock!) { test_qiita_article2 }
        qiita_articles = QiitaArticles.new
        qiita_articles.instance_variable_set(:@fetched_articles, test_qiita_articles)
        qiita_articles.stock!
      end
    end

    context '#stocked_uuids' do
      let(:uuid1) { 'uuid1' }
      let(:uuid2) { 'uuid2' }
      let(:uuids) { [uuid1, uuid2] }

      it 'stocked_itemsに保存されているitems_collectionそれぞれの#uuidを返す' do
        expect(test_qiita_article1).to receive(:uuid) { uuid1 }
        expect(test_qiita_article2).to receive(:uuid) { uuid2 }
        qiita_articles = QiitaArticles.new
        qiita_articles.instance_variable_set(:@stocked_articles, test_qiita_articles)
        expect(qiita_articles.stocked_uuids).to eq(uuids)
      end
    end
  end
end
