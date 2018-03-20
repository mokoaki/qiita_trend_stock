# frozen_string_literal: true

require 'spec_helper'

module QiitaTrendStock
  describe Item do
    let(:test_uuid) { 'aaaa' }
    let(:test_date) { '2018-01-01 00:00:00 +0900' }

    context '#initialize' do
      it 'blankなuuidはエラー' do
        expect { Item.new(uuid: ' ', time: test_date) }.to raise_error(ArgumentError)
        expect { Item.new(uuid: '',  time: test_date) }.to raise_error(ArgumentError)
        expect { Item.new(uuid: nil, time: test_date) }.to raise_error(ArgumentError)
        expect { Item.new(           time: test_date) }.to raise_error(ArgumentError)
      end

      it 'timeはかなりゆるい' do
        expect { Item.new(uuid: test_uuid)                                   }.to_not raise_error
        expect { Item.new(uuid: test_uuid, time: nil)                        }.to_not raise_error
        expect { Item.new(uuid: test_uuid, time: test_date)                  }.to_not raise_error
        expect { Item.new(uuid: test_uuid, time: Time.zone.parse(test_date)) }.to_not raise_error
      end
    end

    context '#to_hash' do
      let(:item) { Item.new(uuid: test_uuid, time: test_date) }

      it 'uuidとtimeをキーに持ったhashを返すだけ' do
        expect(item.to_hash).to match(uuid: test_uuid, time: test_date)
      end
    end
  end
end
