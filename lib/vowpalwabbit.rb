# dependencies
require "fiddle/import"

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
  self.ffi_lib = ["libvw_c_wrapper.so", "libvw_c_wrapper.dylib", "vw_c_wrapper.dll"]

  # friendlier error message
  autoload :FFI, "vowpalwabbit/ffi"
end
