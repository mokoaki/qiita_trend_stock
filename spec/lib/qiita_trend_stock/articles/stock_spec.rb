# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../lib/qiita_trend_stock/articles/stock'

RSpec.describe QiitaTrendStock::Stock do
  let(:articles_class) do
    Class.new { include QiitaTrendStock::Stock }
  end

  let(:articles) do
    articles_class.new
  end

  let(:uuid1) { 'duplicate_uuid' }
  let(:uuid2) { 'unique_uuid' }
  let(:uuid3) { 'duplicate_uuid' }

  let(:article1) { double(:article1, uuid: uuid1) }
  let(:article2) { double(:article2, uuid: uuid2) }
  let(:article3) { double(:article3, uuid: uuid3) }

  context '#stock!' do
    let(:fetched_articles) do
      [article1, article2, article3]
    end

    context '問題のないarticles' do
      let(:stocked_articles) do
        [article1, article2, article3]
      end

      example '#@fetched_articlesそれぞれの#stock!メソッドを呼び出す' do
        expect(article1).to receive(:stock!)
        expect(article2).to receive(:stock!)
        expect(article3).to receive(:stock!)
        articles.instance_variable_set(:@fetched_articles, fetched_articles)
        articles.stock!
      end

      example '戻り値の配列を@stocked_articlesに格納する' do
        allow(article1).to receive(:stock!).and_return(article1)
        allow(article2).to receive(:stock!).and_return(article2)
        allow(article3).to receive(:stock!).and_return(article3)
        articles.instance_variable_set(:@fetched_articles, fetched_articles)
        articles.stock!
        expect(articles.instance_variable_get(:@stocked_articles)).to eq(stocked_articles)
      end
    end

    context '何らかの理由でストックできなかったarticleがある(nilを返してくる)' do
      let(:stocked_articles) do
        # 3はnilなので対象外
        [article1, article2]
      end

      example 'nilは除いた配列を@stocked_articlesに格納する' do
        allow(article1).to receive(:stock!).and_return(article1)
        allow(article2).to receive(:stock!).and_return(article2)
        allow(article3).to receive(:stock!).and_return(nil)
        articles.instance_variable_set(:@fetched_articles, fetched_articles)
        articles.stock!
        expect(articles.instance_variable_get(:@stocked_articles)).to eq(stocked_articles)
      end
    end
  end

  context '#stocked_uuids' do
    let(:stocked_articles) do
      [article1, article2, article3]
    end

    let(:result_uuids) do
      # 3はduplicateなので対象外
      [uuid1, uuid2]
    end

    example '@stocked_articlesに保存されているarticlesそれぞれの#uuidを返す' do
      expect(article1).to receive(:uuid) { uuid1 }
      expect(article2).to receive(:uuid) { uuid2 }
      expect(article3).to receive(:uuid) { uuid3 }
      articles.instance_variable_set(:@stocked_articles, stocked_articles)
      expect(articles.stocked_uuids).to eq(result_uuids)
    end
  end
end
