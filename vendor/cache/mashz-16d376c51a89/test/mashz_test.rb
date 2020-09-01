require 'minitest/autorun'

if File.absolute_path(Dir.pwd()) == File.dirname(File.absolute_path(__FILE__)) then
	puts("*-")
	require '../lib/mashz.rb'
else
	puts("#-")
	require './lib/mashz.rb'
end

class MashzTest < Minitest::Test

	def test_basic()
		assert_equal("This Is Test.", "this is test.".titleize())
		assert_equal("THi5 3is A Te*t9", "tHi5 3is A te*t9".titleize())
	end

	def test_vowels()
		assert_equal(['i', 'i', 'a', 'e'], "This is a test".vowels())
		assert_equal(['o', 'u', 'e', 'o', 'e'], "you're love".vowels())
		assert_equal(['A', 'a', 'e', 'o', 'I', 'I', 'o', 'u', 'o', 'a', 'E'], "And baby! Let's do IT! I'm your bo7a!E".vowels())
	end

	def test_consonants()
		assert_equal(['M', 'y', 'n', 'm', 's'], "My name is!".consonants())
	end

	def test_hard()
		assert_equal("Abcd Efg Hij Klkmn O P Qrstuv Wxyz", "abcd efg hij klkmn o p qrstuv wxyz".titleize())
	end

	def test_File_uniqFin()
		directory_name = File.dirname(File.absolute_path(__FILE__))
		temp_file = Time.now.hash.positified.to_s+".test_f"
		File.create(File.join(directory_name, temp_file))
		assert(temp_file!=File.uniqFin(temp_file, directory_name))
		File.delete(File.join(directory_name, temp_file))
	end
end
