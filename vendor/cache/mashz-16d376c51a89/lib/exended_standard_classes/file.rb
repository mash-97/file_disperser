
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

