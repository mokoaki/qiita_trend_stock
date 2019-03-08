# frozen_string_literal: true

source 'https://rubygems.org'

gem 'qiita'

group :development do
  gem 'rspec'
  gem 'rspec_junit_formatter'
  gem 'rubocop'
  gem 'simplecov', require: false
end
