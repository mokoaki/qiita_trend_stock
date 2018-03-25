# frozen_string_literal: true

require 'spec_helper'

module QiitaTrendStock
  describe TrendItems do
    context '#fetch' do
      before do
        allow(qiita_client).to receive(:list_items).with(page: 1, per_page: 100, query: 'query1') { qiita_page_object1_1 }
        allow(qiita_client).to receive(:list_items).with(page: 2, per_page: 100, query: 'query1') { qiita_page_object1_2 }
        allow(qiita_client).to receive(:list_items).with(page: 1, per_page: 100, query: 'query2') { qiita_page_object2_1 }
        allow(qiita_client).to receive(:list_items).with(page: 2, per_page: 100, query: 'query2') { qiita_page_object2_2 }

        trend_items.fetch(qiita_client, 'query1')
        trend_items.fetch(qiita_client, 'query2')
      end

      let(:trend_items)  { TrendItems.new }
      let(:qiita_client) { double('qiita_client') }

      let(:qiita_page_object1_1) do
        double(:qiita_page_object1_1, next_page_url: 'dummy', body: page_body1_1)
      end

      let(:page_body1_1) do
        [
          {},                    # => X
          { 'dummy' => 'zzzz' }, # => X
          { :id     => 'zzzz' }, # => X
          { 'id'    => 'aaaa' }, # => O
          { 'id'    => 'bbbb' }  # => O
        ]
      end

      let(:qiita_page_object1_2) do
        # next_page_urlがブランク => 次のページは無い
        double(:qiita_page_object1_2, next_page_url: '', body: page_body1_2)
      end

      let(:page_body1_2) do
        [
          { 'id' => 'bbbb' },
          { 'id' => 'cccc' },
        ]
      end

      let(:qiita_page_object2_1) do
        double(:qiita_page_object2_1, next_page_url: 'dummy', body: page_body2_1)
      end

      let(:page_body2_1) do
        [
          { 'id'    => 'dddd' }, # => O
          { 'id'    => 'eeee' }  # => O
        ]
      end

      let(:qiita_page_object2_2) do
        # next_page_urlがブランク => 次のページは無い
        double(:qiita_page_object2_2, next_page_url: '', body: page_body2_2)
      end

      let(:page_body2_2) do
        [
          { 'id' => 'eeee' }, # => O
          { 'id' => 'aaaa' }, # => O
        ]
      end

      it '@itemsに#uuidメソッドを持つオブジェクトが配列で入る' do
        at_items = trend_items.instance_variable_get(:@items)

        expect(at_items.size).to eq(6)
        expect(at_items[0].uuid).to eq('aaaa')
        expect(at_items[1].uuid).to eq('bbbb')
        expect(at_items[2].uuid).to eq('cccc')
        expect(at_items[3].uuid).to eq('dddd')
        expect(at_items[4].uuid).to eq('eeee')
        expect(at_items[5].uuid).to eq('aaaa')

        items = trend_items.items

        expect(items.size).to eq(5)
        expect(items[0].uuid).to eq('aaaa') # uniqされる
        expect(items[1].uuid).to eq('bbbb')
        expect(items[2].uuid).to eq('cccc')
        expect(items[3].uuid).to eq('dddd')
        expect(items[4].uuid).to eq('eeee')
      end
    end
  end
end
