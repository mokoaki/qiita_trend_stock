# frozen_string_literal: true

require 'spec_helper'

module QiitaTrendStock
  describe TrendItems do
    context '#fetch' do
      before do
        allow(qiita_client).to receive(:list_items).with(page: 1, per_page: 100, query: expect_query) { qiita_page_object1 }
        allow(qiita_client).to receive(:list_items).with(page: 2, per_page: 100, query: expect_query) { qiita_page_object2 }

        trend_items.fetch(qiita_client, stock_keep_deadline)
      end

      let(:trend_items)         { TrendItems.new }
      let(:qiita_client)        { double('qiita_client') }
      let(:stock_keep_deadline) { Time.zone.parse('2018/01/01') }

      let(:expect_query) do
        "stocks:>20 created:>#{stock_keep_deadline.strftime('%F')}"
      end

      let(:qiita_page_object1) do
        double(:qiita_page_object1, next_page_url: 'dummy', body: page_body1)
      end

      let(:page_body1) do
        [
          {},                    # => X
          { 'id'    => 'aaaa' }, # => O
          { 'dummy' => 'bbbb' }, # => X
          { 'id'    => 'cccc' }  # => O
        ]
      end

      let(:qiita_page_object2) do
        # next_page_urlがブランク => 次のページは無い
        double(:qiita_page_object2, next_page_url: '', body: page_body2)
      end

      let(:page_body2) do
        [
          { id:     'dddd' }, # => X
          { 'id' => 'cccc' }, # => O
          { 'id' => 'dddd' }, # => O
          { ''   => 'eeee' }  # => X
        ]
      end

      it '@itemsに#uuidメソッドを持つオブジェクトが配列で入る' do
        items = trend_items.items

        expect(items.size).to eq(3)
        expect(items[0].uuid).to eq('aaaa')
        expect(items[1].uuid).to eq('cccc') # uniqされる
        expect(items[2].uuid).to eq('dddd')
      end
    end
  end
end
