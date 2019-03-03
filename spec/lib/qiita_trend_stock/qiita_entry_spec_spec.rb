# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/qiita_trend_stock/qiita_entry'

module QiitaTrendStock
  RSpec.describe QiitaEntry do
    let(:test_uuid1) { 'test_uuid1' }
    let(:test_uuid2) { 'test_uuid2' }

    context '#initialize' do
      it 'コンストラクタは引数でuuidを初期化する' do
        qiita_entry = QiitaEntry.new(test_uuid1)
        expect(qiita_entry.uuid).to eq(test_uuid1)
      end

      it '引数blankは許さない 絶対にだ' do
        expect { QiitaEntry.new }.to raise_error(ArgumentError)
        expect { QiitaEntry.new('') }.to raise_error(ArgumentError)
        expect { QiitaEntry.new(nil) }.to raise_error(ArgumentError)
      end
    end

    context '.attr_accessor :uuid' do
      it 'uuidが読み書きできる' do
        qiita_entry = QiitaEntry.new(test_uuid1)
        qiita_entry.uuid = test_uuid2
        expect(qiita_entry.uuid).to eq(test_uuid2)
      end
    end

    # TODO
    # このテストが面倒くさいのは設計に間違いがあるから
    context '#stock!' do
      let(:client_dummy) { double(:client_dummy) }
      let(:responce_dummy) { double(:responce_dummy) }

      it '#stock!を呼び出すと#qiita_clientを使い、その返答の#bodyメソッドを呼び出す 戻り値は自分自身' do
        entry_item = QiitaEntry.new(test_uuid1)
        allow(entry_item).to receive(:qiita_client).and_return(client_dummy)
        allow(client_dummy).to receive(:stock_item).with(test_uuid1).and_return(responce_dummy)
        allow(responce_dummy).to receive(:body).and_return(nil)
        expect(entry_item.stock!).to eq(entry_item)
      end
    end
  end
end
