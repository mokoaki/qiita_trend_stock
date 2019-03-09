# frozen_string_literal: true

source 'https://rubygems.org'

gem 'qiita'

group :development do
  gem 'pry'
  gem 'rspec',                 require: false
  gem 'rspec_junit_formatter', require: false
  gem 'rubocop',               require: false
  gem 'simplecov',             require: false
end