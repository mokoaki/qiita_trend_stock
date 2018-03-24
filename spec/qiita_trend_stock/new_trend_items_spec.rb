# frozen_string_literal: true

require 'spec_helper'

module QiitaTrendStock
  describe NewTrendItems do
    let(:new_trend_items) { NewTrendItems.new }

    context '#find' do
      before do
        new_trend_items.find(trend_items, stocked_items)
      end

      let(:stocked_items) { double(:stocked_items, uuids: ['bbbb', 'cccc']) }

      let(:trend_items) do
        double(
          :trend_items,
          items: [
            double(:item, uuid: 'aaaa'), # => O
            double(:item, uuid: 'bbbb'), # => X
            double(:item, uuid: 'cccc'), # => X
            double(:item, uuid: 'dddd')  # => O
          ]
        )
      end

      it '@itemsに#uuidメソッドを持つオブジェクトが配列で入る' do
        items = new_trend_items.items

        expect(items.size).to eq(2)
        expect(items[0].uuid).to eq('aaaa')
        expect(items[1].uuid).to eq('dddd')
      end
    end

    context '#items_stock!' do
      before do
        allow(new_trend_items).to receive(:uuids) { ['aaaa', 'bbbb'] }
        allow(qiita_client).to receive(:stock_item)
        new_trend_items.items_stock!(qiita_client)
      end

      let(:qiita_client) { double(:qiita_client) }

      it '#uuidメソッドで入手したuuidsを引数にqiita_client#stock_itemを実行する' do
        expect(qiita_client).to have_received(:stock_item).with('aaaa')
        expect(qiita_client).to have_received(:stock_item).with('bbbb')
      end
    end
  end
end
