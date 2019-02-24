# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  QIITA_CLIENT = ::Qiita::Client.new(access_token: ENV['QIITA_ACCESS_TOKEN'])
end
