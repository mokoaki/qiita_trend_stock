# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # uuidを保持し stockが可能
  # それだけのクラス このクラスがqiitaの1記事を現している
  class EntryItem
    attr_accessor :uuid

    def initialize(uuid)
      raise ArgumentError if uuid.blank?

      self.uuid = uuid
    end

    def stock!
      result = qiita_client.stock_item(uuid).body
      # stock成功時は body == nil らしい
      result.nil? ? self : nil
    end

    private

    def qiita_client
      QIITA_CLIENT
    end
  end
end
