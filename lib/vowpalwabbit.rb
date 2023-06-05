# dependencies
require "ffi"

# modules
require_relative "vowpalwabbit/model"
require_relative "vowpalwabbit/classifier"
require_relative "vowpalwabbit/regressor"
require_relative "vowpalwabbit/version"

module VowpalWabbit
  class Error < StandardError; end

  class << self
    attr_accessor :ffi_lib
  end
  self.ffi_lib = ["vw_c_wrapper", "libvw_c_wrapper.so.0"]

  # friendlier error message
  autoload :FFI, "vowpalwabbit/ffi"
end
