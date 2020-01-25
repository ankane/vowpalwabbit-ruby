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
  lib_name = FFI.map_library_name("vw_c_wrapper")
  vendor_lib = File.expand_path("../vendor/#{lib_name}", __dir__)
  self.ffi_lib = [vendor_lib]

  # friendlier error message
  autoload :FFI, "vowpalwabbit/ffi"
end
