
module Mashz 
	# Generate random files in the destination directory.
	class RFG
		attr_accessor :dest_dir
		attr_accessor :extentions
		attr_accessor :file_sizes
		attr_accessor :name_table
		attr_accessor :nof
		
		def initialize(dest_dir=Dir.pwd(), number_of_files=3, **hash_args)
			@dest_dir = File.absolute_path(dest_dir)
			@nof = number_of_files
			
			@extentions = [hash_args[:extentions] || ["txt", "jpg", "rd"]]
			@file_sizes = [hash_args[:file_sizes] || [1024*3, 1024*5, 512]]
			@name_table = [hash_args[:name_table] || ["yo", "test", "foo"]]
			
			@extentions.flatten!
			@file_sizes.flatten!
			@name_table.flatten!
		end 
		
		def run()
			created_files = []
			@nof.times do 
				file_name = @name_table.sample()+"."+@extentions.sample()
				file_name = File.uniqFin(file_name, @dest_dir)
				file_path = File.join(@dest_dir, file_name)
				created_files << create_file_with_random_bytes(file_path, @file_sizes.sample())
			end
			return created_files
		end
		
		private 
			def create_file_with_random_bytes(file_path, file_size_b)
				file = File.open(file_path, "wb")
				file_size_b.times do 
					file.print(rand(0...256).chr)
				end
				file.close()
				return file_path
			end
	end 
end 
