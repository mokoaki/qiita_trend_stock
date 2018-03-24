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

      it '@itemsに#uuid,#timeメソッドを持つオブジェクトが配列で入る' do
        items = stocked_items.items

        expect(items.size).to eq(2)
        expect(items[0].uuid).to eq('aaaa')
        expect(items[0].time.to_s).to eq('2018-01-01 01:00:00 +0900')
        expect(items[1].uuid).to eq('bbbb')
        expect(items[1].time.to_s).to eq('2018-01-01 02:00:00 +0900')
      end
    end
  end
end
