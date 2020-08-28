#! /usr/bin/ruby

require 'fileutils'
require '../mashz.rb' if Dir.pwd() == File.dirname(File.absolute_path(__FILE__))

# CPRX is to be translated as Copying files by matching extention regexp
class CPRX

	# Extentions in example: mp4, mp3, jpeg etc.
	def initialize(source_directory=nil, destination_directory=nil, extentions=[])
		@source = source_directory
		@destination = destination_directory
		@extentions = extentions
		@regexp = self.make_extentions_matching_regex_for(@extentions)
	end

	def set_source(source_directory=@source)
		@source = source_directory
	end

	def set_destination(destination_directory=@destination)
		@destination = destination_directory
	end

	def set_extentions(extentions=@extentions)
		@extentions = extentions
		@regexp = self.make_extentions_matching_regex_for(@extentions)
	end

	def set_regexp(regexp = @regexp)
		@regexp = regexp
	end

	def start()
		sleep_time = 2

		puts("----------------------------------------------")
		puts("CPRX started for: ")
		puts("Source: #{@source}")
		puts("Destination: #{@destination}")
		puts("Regexp: #{@regexp}")
		puts("----------------------------------------------")
		puts("sleep(#{sleep_time})")
		sleep(sleep_time)

		puts("Checking Source: #{@source} :: #{exists = Dir.exist?(@source)}")
		raise "Source Is Not Appropriate" if not exists
		puts()

		puts("Checking Destination: #{@destination} :: #{exists = Dir.exist?(@destination)}")
		if not exists then
			puts("destination directory: #{destination} doesn't exist")
			puts("Trying existifying the D directory: #{destination}")
			FileUtils.mkdir(destination)
			raise "Destination Is Not Appropriate" if not Dir.exists?(@destination)
		end
		puts("------------------------------------------------------------------------------------")

		output_f = File.open("cprx:#{Time.now.to_s.split(/\s/)[0..1].join(":")}.out", "w+")

		puts = ->(string) { output_f.puts(string); puts(string);}
		bytes_to_kb = ->(size) {size.to_f/1024**1}
		# bytes_to_mb = ->(size) {size.to_f/1024**2}
		bytes_to_gb = ->(size) {size.to_f/1024**3}

		total_size_processed = 0.0
		total_size_copied = 0.0
		total_successful_copied = 0
		total_copying_attempts = 0
		count = 0

		start_time = Time.now
		Dir::workify(@source) do |file_path|

			file_size = File.size(file_path)
			base_name = File.basename(file_path)
			source_file_path = File.dirname(File.absolute_path(file_path))

			if base_name.match?(@regexp) then
				count = count.next
				puts()
				puts.call("match no: #{count}")
				puts.call("file name: #{base_name}")
				puts.call("source path: #{source_file_path}")

				begin
					total_copying_attempts += 1
					file_name = File.uniqFin(base_name, @destination)
					FileUtils.copy(file_path, File.join(@destination, file_name))

				rescue => exception
					puts.call("Copy Failed ==> #{exception}!")
					puts.call("\n")
				else
					puts.call("copied as: #{file_name}")
					puts.call("file size: #{bytes_to_kb.call(file_size).round(2)} KB")
					puts.call("copy successful!")
					puts.call("\n")
					total_successful_copied += 1
					total_size_copied += file_size
				end
			end

			total_size_processed += file_size
			puts("total successful copied: #{total_successful_copied}")
			puts("total size processed: #{bytes_to_gb.call(total_size_processed).round(3)} GB")

		end
		end_time = Time.now

		puts.call("------------------------------------------------------------------------------------")
		puts.call("Total Copying Attempts: #{total_copying_attempts}")
		puts.call("Total Successful Attempts: #{total_successful_copied}")
		puts.call("Total Size Copied: #{bytes_to_gb.call(total_size_copied).round(3)} GB")
		puts.call("Total Size Processed: #{bytes_to_gb.call(total_size_processed).round(3)} GB")
		puts.call("Processed Time: #{(end_time-start_time).round(2)}s")

		output_f.close()

	end

	private
		include Mashz::Miscellaneous
end
