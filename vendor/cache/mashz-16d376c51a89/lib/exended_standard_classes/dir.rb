
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

