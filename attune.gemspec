# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'attune/version'

Gem::Specification.new do |spec|
  spec.name          = "attune"
  spec.version       = Attune::VERSION
  spec.authors       = ["John Hawthorn"]
  spec.email         = ["john@freerunningtechnologies.com"]
  spec.summary       = %q{Client for the Attune product ranking API.}
  spec.description   = %q{Client for the Attune product ranking API.}
  spec.homepage      = "https://github.com/DigitalStripe/attune-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "faraday", "~> 0.9.0"
  spec.add_dependency "net-http-persistent"

  spec.add_development_dependency "bundler", "~> 1.2"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "yard"
  spec.add_development_dependency "redcarpet", ">= 3.1.1"
  spec.add_development_dependency "simplecov"
end
