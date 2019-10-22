require_relative "lib/vowpalwabbit/version"

Gem::Specification.new do |spec|
  spec.name          = "vowpalwabbit"
  spec.version       = VowpalWabbit::VERSION
  spec.summary       = "Vowpal Wabbit - fast online machine learning - for Ruby"
  spec.homepage      = "https://github.com/ankane/vowpalwabbit"
  spec.license       = "MIT"

  spec.author        = "Andrew Kane"
  spec.email         = "andrew@chartkick.com"

  spec.files         = Dir["*.{md,txt}", "{lib}/**/*"]
  spec.require_path  = "lib"

  spec.required_ruby_version = ">= 2.4"

  spec.add_dependency "ffi"

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "minitest", ">= 5"
  spec.add_development_dependency "numo-narray"
end
