# frozen_string_literal: true

require 'spec_helper'
require_relative '../../../../lib/qiita_trend_stock/articles/user_status'

RSpec.describe QiitaTrendStock::UserStatus do
  let(:articles_class) do
    Class.new { include QiitaTrendStock::UserStatus }
  end

  let(:articles) { articles_class.new }

  let(:test_interface) { double(:test_interface) }

  context '#user_status' do
    example 'Interface.user_statusに委譲する' do
      stub_const('Interface', test_interface)
      expect(test_interface).to receive(:user_status)
      articles.user_status
    end
  end
end
