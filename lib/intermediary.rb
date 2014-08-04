require 'bunny'

require 'active_support/all'
require 'intermediary/version'
require 'intermediary/config'
require 'intermediary/connection'
require 'intermediary/emitter/base'
require 'intermediary/listeners'

require 'intermediary/railtie' if defined?(Rails) && Rails.respond_to?(:application)


module Intermediary
  def self.mode
    @@mode ||= :app
  end

  def self.mode=(mode)
    @@mode = mode
  end

  def self.configure
    @@config = Config.new
    yield(@@config)
  end

  def self.config
    @@config ||= Config.new
  end

  def self.reset_config
    @@config = nil
  end
end
