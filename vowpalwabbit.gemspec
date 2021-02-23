require_relative "lib/vowpalwabbit/version"

Gem::Specification.new do |spec|
  spec.name          = "vowpalwabbit"
  spec.version       = VowpalWabbit::VERSION
  spec.summary       = "Fast online machine learning for Ruby"
  spec.homepage      = "https://github.com/ankane/vowpalwabbit"
  spec.license       = "BSD-3-Clause"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@ankane.org"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.4"

  spec.add_dependency "ffi"
end
