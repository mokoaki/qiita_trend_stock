# frozen_string_literal: true

# 全ての機能を含む
module QiitaTrendStock
  # Itemsはこのクラスで表現される
  class Articles
    def user_status
      auth_headers = QIITA_CLIENT.get_authenticated_user.headers
      allow_keys = %w[Rate-Limit Rate-Remaining Rate-Reset X-Runtime Date]
      result_headers = auth_headers.slice(*allow_keys)
      result_headers['DateJST'] = Time.zone.parse(result_headers['Date']).to_s
      result_headers
    end
  end
end
