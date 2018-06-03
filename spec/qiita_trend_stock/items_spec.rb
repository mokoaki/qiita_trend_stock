# frozen_string_literal: true

require 'spec_helper'

module QiitaTrendStock
  describe Items do
    context '#initialize' do
      it 'コンストラクタは@itemsインスタンス変数を空配列で初期化する' do
        items = Items.new
        expect(items.instance_variable_get(:@items)).to be_empty
      end
    end
  end

  describe Behaviors::Items do
    let(:items) { Class.new { |klass| klass.include(Behaviors::Items) }.new }

    context '#items' do
      before do
        items.instance_variable_set(:@items, dummy_items)
      end

      let(:dummy_items) do
        [
          double(:item, uuid: 'aaaa'),
          double(:item, uuid: 'bbbb'),
          double(:item, uuid: 'aaaa')
        ]
      end

      it '@items(配列)内の各objectの#uuidの結果のユニークな配列(items)を返す' do
        expect(items.items.size).to eq(2)
        expect(items.items[0].uuid).to match('aaaa')
        expect(items.items[1].uuid).to match('bbbb')
      end
    end
  end

  describe Behaviors::Items do
    let(:items) { Class.new { |klass| klass.include(Behaviors::Uuids) }.new }

    context '#uuids' do
      before do
        items.instance_variable_set(:@items, dummy_items)
      end

      let(:dummy_items) do
        [
          double(:item, uuid: 'aaaa'),
          double(:item, uuid: 'bbbb')
        ]
      end

      it '@items(配列)内の各objectの#uuidの結果の配列(uuids)を返す' do
        expect(items.uuids).to match(['aaaa', 'bbbb'])
      end
    end
  end
end
