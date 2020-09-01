#! /usr/bin/ruby

require 'fileutils'
require '../mashz.rb' if Dir.pwd == File.dirname(File.absolute_path(__FILE__))

$FCE_desc =
<<DESC
\tClassifying Files by Extentions
\tFile Classificator (FC)
DESC

module FC
	include Mashz::Miscellaneous
	class FCE
		def initialize(parent_directory=nil, extentions=[])
			@parent_directory = parent_directory
			@extentions = extentions
			@regexp = FC::make_extentions_matching_regex_for(@extentions)
		end

		def set_directory(parent_directory=@parent_directory)
			@parent_directory = parent_directory
		end

		def set_regexp(regexp = @regexp)
			@regexp = regexp
		end

		def start()
			sleep_time = 2

			puts("----------------------------------------------")
			puts("FCE started for: ")
			puts("Stand-Alone Directory: #{@parent_directory}")
			puts("Proposed Extentions: #{@extentions.to_s}")
			puts("Proposed Child Directories: #{@extentions.to_s}")
			puts("Regexp: #{@regexp}")
			puts("----------------------------------------------")
			puts("sleep(#{sleep_time})")
			sleep(sleep_time)

			puts("Checking Parent Directory: #{@parent_directory} :: #{exists = Dir.exists?(@parent_directory)}")
			raise "Source Is Not Appropriate" if not exists
			puts()

			puts("Making Stand For The Child Directories: ")
			FileUtils.mkdir(@extentions, verbose: true)
			puts("Checking Directories: #{check_temp = checkDirectories(@extentions)}")
			puts("WARNING: proposed extentions directory status is false") if not check_temp

		end
	end
end
