
module FileDisperser
  # Generates random folders into specified destination directory.
  class FolderGenerator
    attr_accessor :dest_dir
    attr_accessor :limits
    attr_accessor :name_table

    # **hash_args just takes name_table and limits.
    # => name_table: list of names which will be used for folders during folder creation.
    # => limits: it's an another hash, which takes :dispersion_range and :depth_limit
    # =>  ->  dispersion_range: is the range for in-folder dispersion range. Means
    # =>        max and min number of child folders that will be created in the in-folder.
    # =>  ->  depth_limit: is the limit of depth the folder-generator can go.

    def initialize(dest_dir, **hash_args)
      @dest_dir = dest_dir.dup()
      @name_table = hash_args[:name_table]
      @limits = hash_args[:limits]

      @name_table ||=(1..10).map(&:to_s)
      @limits ||= {:dispersion_range=>(1..10), :depth_limit=>10}

    end

    def randomlyDisperseFoldersInto(directories, tier_range=rand(@limits[:dispersion_range]))
      created_directories = []
      tier_range.times do
        temp_dest_dir = directories.sample()
        dir_name = @name_table.sample()
        temp = File.uniqFin(dir_name, temp_dest_dir)
        FileUtils.mkdir(File.join(temp_dest_dir, temp))
        created_directories << File.join(temp_dest_dir, temp)
      end
      return created_directories
    end

    def gen_folders(**hash_args)
      @name_table = hash_args[:name_table] if hash_args[:name_table] and hash_args[:name_table].class==Array and hash_args[:name_table].length()!=0
      if hash_args[:limits] and hash_args[:limits].class==Hash then #and hash_args[:limits].keys.includes_any?([:dispersion_range, :depth_limit]) then
        @limits = {
          :dispersion_range => hash_args[:limits][:dispersion_range] || @limits[:dispersion_range],
          :depth_limit => hash_args[:limits][:depth_limit] || @limits[:depth_limit]
        }
      end

      FileUtils.mkdir(@dest_dir) if not Dir.exist?(@dest_dir)
      depth_level = 1
      gen_directories = []
      queue = Queue.new
      queue << [@dest_dir]
      while not queue.empty? and depth_level <= @limits[:depth_limit] do
        result = randomlyDisperseFoldersInto(queue.pop())
        gen_directories << result
        queue << result if not result.empty?
        depth_level += 1
      end
      return gen_directories.flatten.compact()
    end
  end
end
