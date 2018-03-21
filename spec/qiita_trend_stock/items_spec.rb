# frozen_string_literal: true

require 'spec_helper'

module QiitaTrendStock
  describe Items do
    let(:items) { Items.new }

    context '#initialize' do
      it 'コンストラクタは@itemsインスタンス変数を初期化する' do
        expect(items.instance_variable_get(:@items)).to be_empty
      end
    end

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

      it '@items(配列)内の各objectの#uuidの結果の配列を返す' do
        expect(items.uuids).to match(['aaaa', 'bbbb'])
      end
    end
  end
end
