
module FileDisperser
  # FileDisperser.new takes a destination direcory and all the files path that needs to be
  # dispersed into the destination directory.
  # During dispersion of files, they just get copied.
  # dispersing_method: Method for using each file one-time or random-time
  # => one_time: default is one-time
  # FileDisperser synopsis:
  # => copies files into the destination directory randomly and recursivley.
  class FileDisperser
    attr_accessor :dest_dir
    attr_accessor :source_files
    attr_accessor :dispersing_method        # :one_time for copy each file one-time
                                            # :random_time for: copy each file random-times
                                            # a number for: copy each file number-times
                                            # an array relate to the number of copy for each file

    def initialize(source_files=[], dest_dir=Dir.pwd(), dispersing_method=:random_times)
      raise("ArgumentError") if source_files.class!=Array
      @dest_dir = dest_dir.dup()
      @source_files = source_files.dup()
      @dispersing_method = dispersing_method
    end

    def run(dispersing_method)
      @dispersing_method = dispersing_method || @dispersing_method

      number_array = @source_files.length.times.collect{1} if @dispersing_method==:one_time
      number_array = @source_files.length.times.collect{@dispersing_method} if @dispersing_method.class==Integer
      number_array = @dispersing_method if @dispersing_method.class==Array
      number_array = @source_files.length.times.collect{rand(@dispersing_method)} if @dispersing_method.class==Range
      src_files_path_hash = @source_files.relate_with_as_hash_value(number_array)

      $fdspsr_log.debug("@source_files: #{@source_files.to_s}")
      $fdspsr_log.debug("src_files_path_hash: \n\t#{src_files_path_hash.to_a.collect{|x|x.to_s}.join("\n\t")}")
      $fdspsr_log.debug("@dest_dir: #{@dest_dir}")
      $fdspsr_log.debug("@dispersing_method: #{@dispersing_method.to_s}")

      dest_directories = Find.find(@dest_dir).select{|path|File.directory?(path)}

      $fdspsr_log.debug("Destination Directories are: \n\t#{dest_directories.join("\n\t")}")
      $fdspsr_log.debug("Calling FileDisperser::disperse_files()")
      copied_paths = FileDisperser.disperse_files(src_files_path_hash, dest_directories)
      $fdspsr_log.debug("All the copied paths: \n\t#{copied_paths.join("\n\t")}")
      $fdspsr_log.debug("Total Copies: #{copied_paths.length}")

      return copied_paths
    end

    def self.disperse_files(src_files_path_hash, dest_directories)
      copied_paths = []
      src_files_path_hash.each do
        |src_file_path, number|
        # do copying number times
        number.times do
          # random sample from the destinations directories
          dest_directory = dest_directories.sample()

          # find the uniq name for the file in the directory and create the path.
          dest_file_name = File.uniqFin(File.basename(src_file_path), dest_directory)
          dest_file_path = File.join(dest_directory, dest_file_name)

          # copy the source file to the destination directory as a unique name.
          FileUtils.cp(src_file_path, dest_file_path)
          copied_paths << dest_file_path
        end
      end
      return copied_paths
    end

  end
end
