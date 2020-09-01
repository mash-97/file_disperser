# run MashzTest
require 'rake/testtask'
require 'rake/clean'

# clening test attempted files 
CLEAN.include("test/*.test_f")
CLEAN.include("test/rfg_test")

namespace :test do
	
	task :mashz do
	  puts("Running mashz_test")
	  puts `ruby ./test/mashz_test.rb`
	end
	
	
	task :rfg => ["check:rfg_test_dir"] do
		puts("Running rfg_test")
		puts `ruby ./test/rfg_test.rb`
	end
	
end

namespace :check do

	task :rfg_test_dir do
		dir_path = File.join(File.absolute_path(__dir__), "test/rfg_test")
		if not Dir.exist?(dir_path) then
			puts("#{File.expand_path(dir_path, __dir__)} doesn't exist, so creating one")
			FileUtils.mkdir(dir_path)
			puts("Created!")
		else
			puts("#{File.expand_path(dir_path, __dir__)} exists!")
		end
	end
	
end
		
		

Rake::TestTask.new(:test => ["check:rfg_test_dir"]) do |t|
  t.pattern = 'test/*_test.rb'
  t.warning = true
end

