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

      it '@itemsにItemインスタンスが配列で入る' do
        items = new_trend_items.items
        item1 = items[0]
        item2 = items[1]

        expect(item1.uuid).to eq('aaaa')
        expect(item2.uuid).to eq('dddd')
      end
    end

    context '#uuids' do
      before do
        new_trend_items.instance_variable_set(:@items, items)
      end

      let(:items) do
        [
          double(:item, uuid: 'aaaa'),
          double(:item, uuid: 'bbbb')
        ]
      end

      it '@itemsに入っているItemインスタンスのuuidメソッドの結果の配列を返す' do
        expect(new_trend_items.uuids).to match(['aaaa', 'bbbb'])
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
