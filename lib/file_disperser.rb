require 'bundler/setup'
require 'mashz'
require "logger"

require "file_disperser/version"
require "file_disperser/file_disperser"
require "file_disperser/folder_generator"


$fdspsr_log = Logger.new($stdout)

module FileDisperser
  class Error < StandardError; end
  # Your code goes here...
end
