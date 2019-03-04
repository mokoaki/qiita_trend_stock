# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../lib/qiita_trend_stock/articles/fetch'

RSpec.describe QiitaTrendStock::Fetch do
  let(:articles_class) do
    Class.new { include QiitaTrendStock::Fetch }
  end

  let(:articles) do
    articles_class.new
  end

  context '#fetch!' do
    # 実装を隠蔽
    let(:test_fetch) { double(:test_fetch) }
    # @fetched_articlesに入るであろう値
    let(:result) { 'result' }

    example 'EncapsulationFetch.fetch!を呼び、戻り値を@fetched_articlesに入れる' do
      # search_queriesを呼びだそうとするので防ぐ
      allow(articles).to receive(:search_queries)

      # 実装を隠蔽
      stub_const('QiitaTrendStock::EncapsulationFetch', test_fetch)
      allow(test_fetch).to receive(:fetch!).and_return(result)

      articles.fetch!
      expect(articles.instance_variable_get(:@fetched_articles)).to eq(result)
    end
  end
end

RSpec.describe QiitaTrendStock::EncapsulationFetch do
  let(:target) do
    QiitaTrendStock::EncapsulationFetch
  end

  let(:uuid1) { 'duplicate_uuid' }
  let(:uuid2) { 'unique_uuid' }
  let(:uuid3) { 'duplicate_uuid' }

  let(:article1) { double(:article1, uuid: uuid1) }
  let(:article2) { double(:article2, uuid: uuid2) }
  let(:article3) { double(:article3, uuid: uuid3) }

  context '#fetch!' do
    let(:interface_result) do
      [
        [article1, article2],
        [article3]
      ]
    end

    let(:result) do
      [article1, article2]
    end

    example '#interface_fetchの戻り値をflatten.uniq(&:uuid)する' do
      allow(target).to receive(:interface_fetch).and_return(interface_result)
      expect(target.fetch!(nil)).to eq(result)
    end
  end

  context '#interface_fetch' do
    let(:test_interface) { double(:test_interface, fetch!: interface_result) }

    let(:query_length) { 2 }

    let(:search_queries) { ['dummy'] * query_length }

    let(:interface_result) do
      [article1, article2]
    end

    let(:result) do
      [[article1, article2]] * query_length
    end

    example '配列で渡したsearch_queries毎に配列で結果が帰ってくる これ後で保守できんのか？' do
      stub_const('Interface', test_interface)
      expect(target.interface_fetch(search_queries)).to eq(result)
    end
  end
end
