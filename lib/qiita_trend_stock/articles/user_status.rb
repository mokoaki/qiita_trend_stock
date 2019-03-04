# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # UserStatus関係
  module UserStatus
    def user_status
      QiitaClient.user_status
    end
  end
end
