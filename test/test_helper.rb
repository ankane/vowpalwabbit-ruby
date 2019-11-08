require "bundler/setup"
Bundler.require(:default)
require "minitest/autorun"
require "minitest/pride"
require "numo/narray" unless defined?(JRUBY_VERSION)
