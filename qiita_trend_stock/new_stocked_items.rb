# frozen_string_literal: true

module QiitaTrendStock
  # ストックしたアイテム達を管理、保存するクラス
  class NewStockedItems < Items
    undef :items
    undef :uuids

    def concat(items_object)
      @items.concat(items_object.items)
    end

    def delete_old_items!(limit)
      @items.keep_if do |item|
        item.time > limit
      end
    end

    def store_stocked_uuids!(qiita_client, stocked_item_uuid)
      temp_items_hash     = items_hash(@items)
      temp_items_json     = items_json(temp_items_hash)
      temp_formatted_json = formatted_json(temp_items_json)

      qiita_client.update_item(
        stocked_item_uuid,
        title: 'stocked_qiita_trend',
        body: temp_formatted_json
      )
    end

    private

    def items_hash(items)
      items.map(&:to_hash)
    end

    def items_json(items_hash)
      items_hash.to_json
    end

    def formatted_json(items_json)
      [
        [/\A\[/, "[\n"],
        [/\]\z/, "\n]"],
        ['},{',  "},\n{"]
      ].inject(items_json) do |result, (from, to)|
        result.gsub(from, to)
      end
    end
  end
end
