# encoding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kafka_adapter/version'

Gem::Specification.new do |spec|
  spec.name          = "kafka_adapter"
  spec.version       = KafkaAdapter::VERSION
  spec.authors       = ['Michal Pisanko']
  spec.email         = ['mpisanko@gmail.com']
  spec.description   = %q{Simple abstraction of kafka producers}
  spec.summary       = %q{Simple abstraction of kafka producers (at the moment wrapping poseidon gem)}
  spec.homepage      = "https://github.com/mpisanko/kafka_adapter"
  spec.license       = "The MIT License"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'poseidon', '~> 0.0.4'

  spec.add_development_dependency 'pry', '~> 0.9'
  spec.add_development_dependency 'bundler', "~> 1.5"
  spec.add_development_dependency 'rspec', '~> 2.14'
end
