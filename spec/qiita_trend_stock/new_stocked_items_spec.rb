# frozen_string_literal: true

require 'spec_helper'

module QiitaTrendStock
  describe NewStockedItems do
    let(:new_stocked_items) { NewStockedItems.new }

    context '#concat' do
      before do
        new_stocked_items.concat(dummy_items)
      end

      let(:dummy_items) { double(:dummy_items, items: ['aaaa', 'bbbb']) }

      it '@itemsは配列で初期化されており、itemsメソッドの返り値をconcatする' do
        items = new_stocked_items.instance_variable_get(:@items)
        expect(items).to match(['aaaa', 'bbbb'])
      end
    end

    context '#delete_old_items!' do
      before do
        new_stocked_items.instance_variable_set(:@items, dummy_items)
        new_stocked_items.delete_old_items!(Time.zone.parse('2018/01/15'))
      end

      let(:dummy_items) do
        [
          double(:item, uuid: 'aaaa', time: Time.zone.parse('2018/01/14')), # => X
          double(:item, uuid: 'bbbb', time: Time.zone.parse('2018/01/15')), # => X
          double(:item, uuid: 'cccc', time: Time.zone.parse('2018/01/16')), # => O
          double(:item, uuid: 'dddd', time: Time.zone.parse('2018/01/17'))  # => O
        ]
      end

      it '@itemsから、指定した日付より前のものは削除しちゃう' do
        items = new_stocked_items.instance_variable_get(:@items)

        expect(items.size).to eq(2)
        expect(items[0].uuid).to eq('cccc')
        expect(items[1].uuid).to eq('dddd')
      end
    end

    context '#store_stocked_uuids!' do
      before do
        new_stocked_items.instance_variable_set(:@items, dummy_items)
        allow(qiita_client).to receive(:update_item)
        new_stocked_items.store_stocked_uuids!(qiita_client, dumy_uuid)
      end

      let(:qiita_client) { double(:qiita_client) }
      let(:dumy_uuid)    { 'uuid' }

      let(:dummy_items) do
        [
          double(:item, to_hash: {uuid: 'aaaa', time: Time.zone.parse('2018/01/14') }),
          double(:item, to_hash: {uuid: 'bbbb', time: Time.zone.parse('2018/01/15') })
        ]
      end

      let(:expect_json) do
        [
          %([),
          %({"uuid":"aaaa","time":"2018-01-14T00:00:00.000+09:00"},),
          %({"uuid":"bbbb","time":"2018-01-15T00:00:00.000+09:00"}),
          %(])
        ].join("\n")
      end

      it '@itemsをjson化し、qiita_client#update_itemの引数として実行する' do
        expect(qiita_client).to have_received(:update_item).with(
          dumy_uuid,
          title: 'stocked_qiita_trend',
          body: expect_json
        )
      end
    end
  end
end
