# frozen_string_literal: true

require 'bundler/setup'
Bundler.require(:default, :development)
require 'active_support'
require 'active_support/core_ext'

Time.zone = 'Asia/Tokyo'

directory_path = File.expand_path('../lib/qiita_trend_stock', __dir__)
$LOAD_PATH.unshift(directory_path)

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
