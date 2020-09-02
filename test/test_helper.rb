$LOAD_PATH.unshift File.expand_path("../lib", __dir__)

require "find"
require "tty-tree"
require "timeout"
require "file_disperser"
# require_relative "test_paths"

class TestHelper
  ASSETS_PATH = File.join(File.absolute_path(__dir__),"assets")
  TEST_BASE_PATH = File.join(File.absolute_path(__dir__), "test_base")
end
