# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # uuidを保持し stockが可能
  # それだけのクラス このクラスがqiitaの1記事を現している
  class Article
    attr_reader :uuid

    def initialize(uuid)
      raise ArgumentError if uuid.blank?

      @uuid = uuid
    end

    # TODO
    # 実装定数を参照しているのはどうなんだ？とは思う
    def stock!
      result = QiitaInterface.stock_item(uuid)
      result ? self : nil
    end
  end
end
