# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'intermediary/version'

Gem::Specification.new do |spec|
  spec.name          = 'intermediary'
  spec.version       = Intermediary::VERSION
  spec.authors       = ['Michael Schaefermeyer']
  spec.email         = %w(michael.schaefermeyer@gmail.com)
  spec.summary       = 'Command post emits and subscribes to BR updates.'
  spec.description   = """
  This gem is responsible for emitting and receiving updates to changes
  that occur within an app.
  """
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_dependency 'bunny', '~> 1.3'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'guard-rspec', '~> 4.2'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
