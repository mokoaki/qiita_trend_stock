# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/qiita_trend_stock/stock'

module QiitaTrendStock
  RSpec.describe QiitaEntries do
    let(:test_qiita_entry1) { double(:test_qiita_entry1) }
    let(:test_qiita_entry2) { double(:test_qiita_entry2) }
    let(:test_qiita_entries) { [test_qiita_entry1, test_qiita_entry2] }

    context '#stock!' do
      it 'entry_itemsに保存されているitems_collectionそれぞれの#stock!メソッドを呼び出す' do
        expect(test_qiita_entry1).to receive(:stock!) { test_qiita_entry1 }
        expect(test_qiita_entry2).to receive(:stock!) { test_qiita_entry2 }
        qiita_entries = QiitaEntries.new
        qiita_entries.instance_variable_set(:@entry_items, test_qiita_entries)
        qiita_entries.stock!
      end
    end

    context '#stocked_uuids' do
      let(:uuid1) { 'uuid1' }
      let(:uuid2) { 'uuid2' }
      let(:uuids) { [uuid1, uuid2] }

      it 'stocked_itemsに保存されているitems_collectionそれぞれの#uuidを返す' do
        expect(test_qiita_entry1).to receive(:uuid) { uuid1 }
        expect(test_qiita_entry2).to receive(:uuid) { uuid2 }
        qiita_entries = QiitaEntries.new
        qiita_entries.instance_variable_set(:@stocked_items, test_qiita_entries)
        expect(qiita_entries.stocked_uuids).to eq(uuids)
      end
    end
  end
end
