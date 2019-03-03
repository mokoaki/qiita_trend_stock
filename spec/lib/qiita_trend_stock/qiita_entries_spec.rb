# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../lib/qiita_trend_stock/qiita_entries'

module QiitaTrendStock
  RSpec.describe QiitaEntries do
    let(:fetch_entries) { QiitaEntries.new }

    context '#initialize' do
      it 'コンストラクタは[entry_items,stocked_items]を空配列で初期化する' do
        expect(fetch_entries.instance_variable_get(:@entry_items)).to eq([])
        expect(fetch_entries.instance_variable_get(:@stocked_items)).to eq([])
      end
    end
  end
end
