require "minitest/autorun"
if File.absolute_path(Dir.pwd()) == File.dirname(File.absolute_path(__FILE__)) then
	puts("*-")
	require '../lib/mashz.rb'
else
	puts("#-")
	require './lib/mashz.rb'
end

include Mashz 

class RFGTest < Minitest::Test
	@@dest_dir = File.join(File.absolute_path(__dir__), "rfg_test")
	@@number_of_files = 50
	@@extentions = ["txtt", "ttt", "tbt", "exe", "cxc"]
	@@name_table = ["fixi", "jixi", "nixi"]
	@@file_sizes = [5, 100, 1000, 10234]
	
	def test_rfg_with_test_args()
		rfg = RFG.new(@@dest_dir, 
			@@number_of_files, 
			extentions: @@extentions, 
			name_table: @@name_table,
			file_sizes: @@file_sizes
		)
		
		assert_equal(rfg.dest_dir, @@dest_dir)
		assert_equal(rfg.nof, @@number_of_files)
		assert_equal(rfg.name_table, @@name_table)
		assert_equal(rfg.extentions, @@extentions)
		assert_equal(rfg.file_sizes, @@file_sizes)
		created_files = rfg.run()
		
		# check file_names
		fmr = Regexp.new("(#{rfg.name_table.join("|")}).*\\.(#{rfg.extentions.join("|")})$")
		created_files.each do |file_path|
			assert(file_path=~fmr)
		end
		
		# check file_sizes
		created_files.each do |file_path|
			assert(rfg.file_sizes.include?(File.size(file_path)))
		end
	end 
	
	def test_rfg_with_default_args()
		rfg = RFG.new(@@dest_dir)
		assert_equal(rfg.dest_dir, @@dest_dir)
		assert_equal(rfg.nof, 3)
		assert_equal(rfg.name_table, ["yo", "test", "foo"])
		assert_equal(rfg.extentions, ["txt", "jpg", "rd"])
		assert_equal(rfg.file_sizes, [1024*3, 1024*5, 512])
		created_files = rfg.run()
		
		# check file_names
		fmr = Regexp.new("(#{rfg.name_table.join("|")}).*\.(#{rfg.extentions.join("|")})$")
		
		created_files.each do |file_path|
			assert(file_path=~fmr)
		end
		
		# check file_sizes
		created_files.each do |file_path|
			assert(rfg.file_sizes.include?(File.size(file_path)))
		end
	end
end
		
