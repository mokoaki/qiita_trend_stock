# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../lib/qiita_trend_stock/article/base'

RSpec.describe QiitaTrendStock::Article do
  let(:article) do
    described_class.new(uuid1)
  end

  let(:uuid1) { 'uuid1' }
  let(:uuid2) { 'uuid2' }

  context '#initialize' do
    example 'コンストラクタは引数で@uuidを初期化する' do
      expect(article.instance_variable_get(:@uuid)).to eq(uuid1)
    end

    example '引数blankは許さない 絶対にだ' do
      expect { described_class.new }.to raise_error(ArgumentError)
      expect { described_class.new('') }.to raise_error(ArgumentError)
      expect { described_class.new(nil) }.to raise_error(ArgumentError)
    end
  end

  context '.attr_reader :uuid' do
    example '@uuidが読める' do
      article.instance_variable_set(:@uuid, uuid2)
      expect(article.uuid).to eq(uuid2)
    end
  end

  context '#stock!' do
    let(:test_client) { double(:test_client) }

    before(:example) do
      stub_const('QiitaClient', test_client)
    end

    example '#stock!を呼び出すとClient.stock_itemを呼び出し、trueならselfを返す' do
      allow(test_client).to receive(:stock_item).and_return(true)
      expect(article.stock!).to eq(article)
    end

    example '#stock!を呼び出すとClient.stock_itemを呼び出し、falseならnilを返す' do
      allow(test_client).to receive(:stock_item).and_return(false)
      expect(article.stock!).to eq(nil)
    end
  end
end
