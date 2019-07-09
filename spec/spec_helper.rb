require_relative '../config/environment'
require 'capybara'
require 'rack/test'
require 'capybara/rspec'

RSpec.configure do |config|
  config.include Capybara::DSL
  config.include Rack::Test::Methods
  config.order = 'default'
end

def app
  Rack::Builder.parse_file('config.ru').first
end

Capybara.app = app

def session
  last_request.env['rack.session']
end

#run rspec --color --format doc
