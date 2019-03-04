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
  end

  context '.attr_reader :uuid' do
    example '@uuidが読める' do
      article.instance_variable_set(:@uuid, uuid2)
      expect(article.uuid).to eq(uuid2)
    end
  end

  context '#stock!' do
    let(:test_interface) { double(:test_interface) }

    before(:example) do
      stub_const('QiitaInterface', test_interface)
    end

    example 'Interface.stock_itemを呼び出し、trueならselfを返す' do
      allow(test_interface).to receive(:stock_item).and_return(true)
      expect(article.stock!).to eq(article)
    end

    example 'Interface.stock_itemを呼び出し、falseならnilを返す' do
      allow(test_interface).to receive(:stock_item).and_return(false)
      expect(article.stock!).to eq(nil)
    end
  end
end
