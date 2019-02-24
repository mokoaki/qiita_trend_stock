# frozen_string_literal: true

require 'spec_helper'

module QiitaTrendStock
  RSpec.describe EntryItems do
    let(:test_entry_item1) { double(:test_entry_item1) }
    let(:test_entry_item2) { double(:test_entry_item2) }
    let(:test_entry_items) { [test_entry_item1, test_entry_item2] }

    context '#stock!' do
      it 'entry_itemsに保存されているitems_collectionそれぞれの#stock!メソッドを呼び出す' do
        expect(test_entry_item1).to receive(:stock!)
        expect(test_entry_item2).to receive(:stock!)
        entry_items = EntryItems.new
        entry_items.entry_items = test_entry_items
        entry_items.stock!
      end
    end

    context '#stocked_uuids' do
      let(:test_uuid1) { 'test_uuid1' }
      let(:test_uuid2) { 'test_uuid2' }
      let(:test_uuids) { [test_uuid1, test_uuid2] }

      it 'stocked_itemsに保存されているitems_collectionそれぞれの#uuidを返す' do
        allow(test_entry_item1).to receive(:uuid) { test_uuid1 }
        allow(test_entry_item2).to receive(:uuid) { test_uuid2 }
        entry_items = EntryItems.new
        entry_items.stocked_items = test_entry_items
        expect(entry_items.stocked_uuids).to eq(test_uuids)
      end
    end
  end
end
