# frozen_string_literal: true

require 'spec_helper'

module QiitaTrendStock
  describe StockedItems do
    let(:stocked_items) { StockedItems.new }

    context '#fetch' do
      before do
        allow(stocked_items).to receive(:qiita_stocked_item)
        allow(stocked_items).to receive(:qiita_stocked_item_json) { test_json }
        stocked_items.fetch('dummy_client', 'dummy_item_uuid')
      end

      let(:test_json) do
        [
          { 'uuid' => 'aaaa', 'time' => '2018-01-01 01:00:00 +0900' },
          { 'uuid' => 'bbbb', 'time' => '2018-01-01 02:00:00 +0900' }
        ].to_json
      end

      it '@itemsにItemインスタンスが配列で入る' do
        items = stocked_items.items
        item1 = items[0]
        item2 = items[1]

        expect(item1.uuid).to eq('aaaa')
        expect(item1.time.to_s).to eq('2018-01-01 01:00:00 +0900')
        expect(item2.uuid).to eq('bbbb')
        expect(item2.time.to_s).to eq('2018-01-01 02:00:00 +0900')
      end
    end

    context '#uuids' do
      before do
        stocked_items.instance_variable_set(:@items, items)
      end

      let(:items) do
        [
          double(:item, uuid: 'aaaa'),
          double(:item, uuid: 'bbbb')
        ]
      end

      it '@itemsに入っているItemインスタンスのuuidメソッドの結果の配列を返す' do
        expect(stocked_items.uuids).to match(['aaaa', 'bbbb'])
      end
    end
  end
end
