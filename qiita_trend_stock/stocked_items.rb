# frozen_string_literal: true

module QiitaTrendStock
  # 既にストックしたアイテムの一覧をQiitaに保存しているので、それを取ってくる
  class StockedItems < Items
    def fetch(qiita_client, stocked_item_uuid)
      stocked_item      = qiita_stocked_item(qiita_client, stocked_item_uuid)
      stocked_item_json = qiita_stocked_item_json(stocked_item)
      stocked_items     = qiita_stocked_items(stocked_item_json)
      @items            = self_items(stocked_items)
    end

    private

    def qiita_stocked_item(qiita_client, stocked_item_uuid)
      qiita_client.get_item(stocked_item_uuid)
    end

    def qiita_stocked_item_json(stocked_item)
      stocked_item.body['body']
    end

    def qiita_stocked_items(stocked_item_json)
      JSON.parse(stocked_item_json)
    end

    def self_items(stocked_items)
      stocked_items.map do |item|
        Item.new(uuid: item['uuid'], time: item['time'])
      end
    end
  end
end
