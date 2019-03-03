# frozen_string_literal: true

require 'singleton'
# require_relative './user_status'
require_relative './qiita_client'

# 全ての機能を含む
module QiitaTrendStock
  # あーなんて書こう
  class Client
    include Singleton
    # include UserStatus
    include QiitaClient
  end
end
