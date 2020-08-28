
module FileDisperser
  class FolderGenerator
    attr_accessor :dest_dir
    attr_accessor :limits
    attr_accessor :name_table

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

    def gen_folders()
      FileUtils.mkdir(@dest_dir) if not Dir.exist?(@dest_dir)
      depth_level = 1
      total_dirs = 1
      queue = Queue.new
      queue << [@dest_dir]
      while not queue.empty? and depth_level <= @limits[:depth_limit] do
        result = randomlyDisperseFoldersInto(queue.pop())
        total_dirs += result.length()
        queue << result if not result.empty?
        depth_level += 1
      end
      return total_dirs
    end
  end
end
