require 'minitest/autorun'
if File.absolute_path(Dir.pwd()) == File.dirname(File.absolute_path(__FILE__)) then
  puts("*-*")
  require '../lib/mashz.rb'
else
  puts("#-#")
	require './lib/mashz.rb'
end


class CPRXTest < Minitest::Test

end
