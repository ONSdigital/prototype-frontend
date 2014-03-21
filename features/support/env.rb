# Generated by cucumber-sinatra. (2014-03-21 11:58:21 +0000)

ENV['RACK_ENV'] = 'test'

require File.join(File.dirname(__FILE__), '..', '..', 'ons_frontend.rb')

require 'capybara'
require 'capybara/cucumber'
require 'rspec'

Capybara.app = OnsFrontend

class OnsFrontendWorld
  include Capybara::DSL
  include RSpec::Expectations
  include RSpec::Matchers
end

World do
  OnsFrontendWorld.new
end
