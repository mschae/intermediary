$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)

require 'bundler'
Bundler.setup(:default, :test)

require 'intermediary'

RSpec.configure do |config|
  config.mock_with :rspec
end
