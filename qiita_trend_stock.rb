# frozen_string_literal: true

require 'bundler/setup'
require 'active_support'
require 'active_support/core_ext'
require 'qiita'
require 'open-uri'

Time.zone = 'Asia/Tokyo'

module QiitaTrendStock
  class Client
    class << self
      def new(access_token)
        @new ||= ::Qiita::Client.new(access_token: access_token)
      end
    end
  end

  class Item
    attr_reader :uuid, :time

    def initialize(uuid:, time: nil)
      @uuid = uuid
      @time = time_calc(time)
    end

    private

    def time_calc(time)
      parsed_time = time_parse(time)

      return parsed_time if parsed_time.instance_of?(ActiveSupport::TimeWithZone)
      raise ArgumentError, time
    end

    def time_parse(time)
      return Time.zone.parse(time) if time.instance_of?(String)
      return Time.zone.now         if time.nil?

      time
    end
  end

  class Items
    attr_reader :items

    def initialize
      @items = []
    end

    def uuids
      @uuids ||= @items.map(&:uuid).compact
    end

    def items_hash
      @items.map do |item|
        { uuid: item.uuid, time: item.time.to_s }
      end
    end

    def items_json
      items_hash.to_json
    end

    def formatted_json
      [
        [/\A\[/, "[\n"],
        [/\]\z/, "\n]"],
        ['},{',  "},\n{"]
      ].inject(items_json) do |result, (from, to)|
        result.gsub(from, to)
      end
    end

    def add_item(item)
      @items << item
    end
  end

  class TrendItems < Items
    attr_reader :items

    def initialize(qiita_trend_uri)
      super()

      trend_item_uuids = qiita_trend_item_uuids(qiita_trend_uri)

      trend_item_uuids.each do |uuid|
        add_item Item.new(uuid: uuid)
      end
    end

    private

    def qiita_trend_item_uuids(qiita_trend_uri)
      trend_items = qiita_trend_items(qiita_trend_uri)
      trend_items.map { |item| item.dig('article', 'uuid').presence }.compact
    end

    def qiita_trend_items(qiita_trend_uri)
      trend_item_json = qiita_trend_item_json(qiita_trend_uri)
      JSON.parse(trend_item_json)['trendItems']
    end

    def qiita_trend_item_json(qiita_trend_uri)
      Kernel.open(qiita_trend_uri).read
    end
  end

  class StockedItems < Items
    def initialize(qiita_client, stocked_item_uuid)
      super()

      stocked_items = qiita_stocked_items(qiita_client, stocked_item_uuid)

      stocked_items.each do |item|
        add_item Item.new(uuid: item['uuid'], time: item['time'])
      end
    end

    private

    def qiita_stocked_items(qiita_client, stocked_item_uuid)
      stocked_item_json = qiita_stocked_item_json(qiita_client, stocked_item_uuid)
      JSON.parse(stocked_item_json)
    end

    def qiita_stocked_item_json(qiita_client, stocked_item_uuid)
      stocked_item = qiita_stocked_item(qiita_client, stocked_item_uuid)
      stocked_item.body['body']
    end

    def qiita_stocked_item(qiita_client, stocked_item_uuid)
      qiita_client.get_item(stocked_item_uuid)
    end
  end

  class NewTrendItems < Items
    def initialize(trend_items, stocked_items)
      super()

      @items = qiita_new_trend_items(trend_items, stocked_items)
    end

    def items_stock(qiita_client)
      @items.each do |item|
        qiita_client.stock_item(item.uuid)
      end
    end

    private

    def qiita_new_trend_items(trend_items, stocked_items)
      trend_items.items.find_all do |item|
        stocked_items.uuids.exclude?(item.uuid)
      end
    end
  end

  class NewStockedItems < Items
    def initialize(new_trend_items, stocked_items)
      super()

      @items = qiita_new_stocked_items(new_trend_items, stocked_items)
    end

    def save_stocked_uuids(qiita_client, stocked_item_uuid)
      qiita_client.update_item(
        stocked_item_uuid,
        title: 'stocked_qiita_trend',
        body: formatted_json
      )
    end

    private

    def qiita_new_stocked_items(new_trend_items, stocked_items)
      new_trend_items.items + stocked_items.items
    end
  end

  module Main
    class << self
      def start(qiita_trend_uri:, qiita_access_token:, stocked_item_uuid:)
        trend_items = TrendItems.new(qiita_trend_uri)

        qiita_client = Client.new(qiita_access_token)

        stocked_items = StockedItems.new(qiita_client, stocked_item_uuid)

        new_trend_items = NewTrendItems.new(trend_items, stocked_items)
        new_trend_items.items_stock(qiita_client)

        new_stocked_items = NewStockedItems.new(new_trend_items, stocked_items)
        new_stocked_items.save_stocked_uuids(qiita_client, stocked_item_uuid)

        output_log(qiita_client, new_trend_items)
      end

      def output_log(qiita_client, new_trend_items)
        auth_headers      = qiita_client.get_authenticated_user.headers
        result_allow_keys = %w[Date Rate-Limit Rate-Remaining Rate-Reset X-Runtime]
        result_headers    = auth_headers.slice(*result_allow_keys)

        p Time.zone.parse(result_headers['Date']).to_s
        pp result_headers
        pp new_trend_items.uuids
        p '( ｰ`дｰ´) おｋ'
      end
    end
  end
end

QiitaTrendStock::Main.start(
  qiita_trend_uri:    'https://qiita.com/trend.json',
  qiita_access_token: ENV['qiita_access_token'],
  stocked_item_uuid:  ENV['stocked_item_uuid']
)
