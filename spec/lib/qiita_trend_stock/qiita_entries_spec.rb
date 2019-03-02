# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/qiita_trend_stock/qiita_entries'

module QiitaTrendStock
  RSpec.describe QiitaEntries do
    let(:entry_items) { QiitaEntries.new }

    context '#initialize' do
      it 'コンストラクタは[entry_items,stocked_items]を空配列で初期化する' do
        expect(entry_items.entry_items).to eq([])
        expect(entry_items.stocked_items).to eq([])
      end
    end

    context '.attr_accessor' do
      let(:dummy) { 'dummy' }

      # TODO
      # entry_items.entry_items とかややこしいからどうにかしたほうがいい

      context ':entry_items' do
        it 'entry_itemsが読み書きできる' do
          entry_items.entry_items = dummy
          expect(entry_items.entry_items).to eq(dummy)
        end
      end

      context ':stocked_items' do
        it 'stocked_itemsが読み書きできる' do
          entry_items.stocked_items = dummy
          expect(entry_items.stocked_items).to eq(dummy)
        end
      end
    end
  end
end
