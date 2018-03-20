# frozen_string_literal: true

module QiitaTrendStock
  class Item
    attr_reader :uuid, :time

    def initialize(uuid:, time: nil)
      @uuid = validate_uuid(uuid)
      @time = validate_time(time)
    end

    def to_hash
      { uuid: @uuid, time: @time.to_s }
    end

    private

    def validate_uuid(uuid)
      result = uuid.to_s.gsub(/\A[[:space:]]+|[[:space:]]+\z/, '')
      raise ArgumentError, uuid if result.blank?
      result
    end

    def validate_time(time)
      return time if time.instance_of?(ActiveSupport::TimeWithZone)

      parsed_time = time_parse(time)
      return parsed_time if parsed_time.instance_of?(ActiveSupport::TimeWithZone)

      # 何か変な事になっても、とりあえず今の日時を返す
      # この日付はストックした履歴を確認したいだけで、特に重要ではないからである
      Time.zone.now
    end

    def time_parse(time)
      Time.zone.parse(time)
    rescue StandardError
      nil
    end
  end
end
