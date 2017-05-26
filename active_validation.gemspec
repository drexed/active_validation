# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'active_validation/version'

Gem::Specification.new do |spec|
  spec.name = 'active_validation'
  spec.version = ActiveValidation::VERSION
  spec.authors = ['Juan Gomez']
  spec.email = ['j.gomez@drexed.com']

  spec.summary = 'Gem for commonly used validators.'
  spec.description = 'Validate commonly used attributes easily with ActiveValidation.'
  spec.homepage = 'http://drexed.github.io/active_validation'
  spec.license = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = %w[lib]

  spec.add_runtime_dependency 'activemodel'
  spec.add_runtime_dependency 'activesupport'

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'shoulda'
  spec.add_development_dependency 'fasterer'
  spec.add_development_dependency 'reek'
  spec.add_development_dependency 'rubocop'
end
