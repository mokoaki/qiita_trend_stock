# frozen_string_literal: true

require 'bundler/setup'
Bundler.require(:default, :development)
require 'active_support'
require 'active_support/core_ext'

Time.zone = 'Asia/Tokyo'

# directory_path = File.expand_path('../lib', __dir__)
# $LOAD_PATH.unshift(directory_path)

# if ENV['CIRCLE_WORKING_DIRECTORY'].present?
require 'simplecov'
root_dir = ENV['CIRCLE_WORKING_DIRECTORY'] || File.expand_path('../', __dir__)
coverage_dir = File.join(root_dir, 'coverage')
SimpleCov.start do
  coverage_dir(coverage_dir)
  track_files('lib/**/*.rb')
  add_filter('/spec/')
end
# end

# require_relative '../lib/qiita_trend_stock'

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  # config.example_status_persistence_file_path = '.rspec_status'

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.order = 'random'

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
