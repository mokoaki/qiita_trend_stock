# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  module UserStatus
    def user_status
      QiitaClient.user_status
    end
  end
end
