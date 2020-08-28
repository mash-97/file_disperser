class Integer
	@@factorial_hash = Hash.new do
		|hself, key|
		hself[key] = (key==0 ? 1 : (Math::gamma(key).floor)*key)
	end

	def facto
		return @@factorial_hash[self]
	end

	def factorial
		(1..self).inject{|x,y| x*y}
	end

	def positify
		return self.positive? ? self : self*(-1)
	end


	def bits
		number = self
		bits = ""
		if(self==0) then return '0' end
		until number==0 do
			bits << (number&1).to_s
			number >>=1
		end
		return bits.reverse
	end

	alias :positified :positify
end


class Float
	def positify()
		return self.positive? ? self : self * (-1)
	end
	alias :positified :positify
end


class Array

	$Array_strip_voids_desc =
<<DESC
\tArray@strip_voids()\n
\t--> strips voids (nil or free spaces)
\t--> returns an array by stripping nil or space elements
\t--> strip_voids!() uses O(n^2)
DESC

	def strip_voids()
		array = []
		self.each{|element| array << element if not element.to_s.strip.length==0}
		return array
	end

	def strip_voids!
		indx = 0
		while indx < self.length do
			if self[indx].to_s.strip.length == 0 then
				self.delete(self[indx])
			else
				indx += 1
			end
		end

		return self
	end

	def nprint()
		(0...(self.length-1)).each{|indx| print("#{self[indx]} ")}
		puts(print(self[self.length-1]))
	end

end


class String
	def vowels()
		self.scan(/[aeiouAEIOU]/)
	end

	def consonants()
		self.scan(/[^aeiouAEIOU\W\d]/)
	end

	def titleize()
		self.gsub(/(\A|\s)\w/){|letter| letter.upcase}
	end
end


class File

	$File_uniqFin_desc =
<<DESC
\tFile::uniqFin(basename, directory=Dir.pwd())\n
\t--> Modifies the basename to have a uniq file name trailed
\t--> with a unique hash id according to the file names in the
\t--> current directory.
DESC

	def self.uniqFin(basename, directory=Dir.pwd(), max_trials=100)
		$mashz_log.info("Inside File::uniqFin() with:\n\tbasename: #{basename}\n\tdirectory: #{directory}")


		if not Dir.exist?(directory) then
			$mashz_log.warn("directory: #{directory} not found!")
			return false
		end

		directory = File.absolute_path(directory)
		file_name = File.basename(basename)
		ext = File.extname(basename)

		$mashz_log.info("directory: #{File.basename(directory)}")
		$mashz_log.info("file_name: #{file_name}")
		$mashz_log.info("extention: #{ext}")

		c_trials = 1

		while File.exist?(File.join(directory, file_name)) and c_trials <= max_trials do
			$mashz_log.debug("c_trials: #{c_trials}")

			if ext.length != 0 then
				file_name = basename.sub(ext, "_"+Time.now.hash.positified.to_s+ext)
				$mashz_log.debug("if: file_name: #{file_name}")
			else
				file_name = basename+"_"+Time.now.hash.positified.to_s
				$mashz_log.debug("else: file_name: #{file_name}")
			end
			c_trials += 1
		end

		$mashz_log.info("return: file_name: #{file_name}")
		return file_name
	end

	def self.size_mb(file_path, round_val=6)
		(File.size(file_path).to_f / 1024**2).round(round_val)
	end

	def self.create(file_name)
		File.open(file_name, "w").close()
	end
end


class Dir

	$Dir_workify_desc =
<<DESC
\tDir#workify(dir_path, sym_ign=false, &block)\n
\t--> this method is used to yield the given block under terms of working with all the elements inside of the given dir_path.
\t--> returns the array of the elements inside of the dir_path
\t--> returns false if the dir_path doesn't exist
\t--> Ignores Symbolic Link to yield at default
DESC

	def self.workify(dir_path, sym_ign=false, &block)
		return false if not Dir.exist?(dir_path)


		Dir.foreach(dir_path) do |file_name|
			file_path = File.join(dir_path, file_name)

			next if file_name == "." or file_name == ".." or (File.symlink?(file_path) and not sym_ign)

			Dir.workify(file_path, sym_ign, &block) if File.directory?(file_path)

			yield(file_path) if File.file?(file_path)
		end
	end
end

class Object
	def to_obj
		return eval(self.to_s)
	end
end
