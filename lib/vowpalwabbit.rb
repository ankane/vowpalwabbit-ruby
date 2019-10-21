# dependencies
require "ffi"

# modules
require "vowpalwabbit/model"
require "vowpalwabbit/classifier"
require "vowpalwabbit/regressor"
require "vowpalwabbit/version"

module VowpalWabbit
  class Error < StandardError; end

  class << self
    attr_accessor :ffi_lib
  end
  self.ffi_lib = ["vw_c_wrapper"]

  # friendlier error message
  autoload :FFI, "vowpalwabbit/ffi"
end
