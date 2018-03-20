# frozen_string_literal: true

require 'spec_helper'

module QiitaTrendStock
  describe TrendItems do
    context '#fetch' do
      before do
        allow(trend_items).to receive(:qiita_trend_item_json) { test_json }
        trend_items.fetch('dummy_uri')
      end

      let(:trend_items) { TrendItems.new }

      let(:test_json) do
        {
          'trendItems' => [
            { 'article' => { 'uuid'  => 'aaaa' } }, # => O
            { 'dummy'   => { 'uuid'  => 'bbbb' } }, # => X
            { 'article' => { 'dummy' => 'cccc' } }, # => X
            { 'article' => { 'uuid'  => 'dddd' } }  # => O
          ]
        }.to_json
      end

      it '@itemsにItemインスタンスが配列で入る' do
        items = trend_items.items
        item1 = items[0]
        item2 = items[1]

        expect(item1.uuid).to eq('aaaa')
        expect(item2.uuid).to eq('dddd')
      end
    end
  end
end
