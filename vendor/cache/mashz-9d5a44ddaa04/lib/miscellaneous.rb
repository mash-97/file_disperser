module Mashz::Miscellaneous

  def make_extentions_matching_regex_for(extentions=nil)
    return Regexp.new("\\.(#{extentions.join('|')})$", 'i')
  end

  def checkDirectories(directory_names=[])
  	directory_names.each do |dname|
  		return false if not Dir.exists?(dname)
  	end
  	return true
  end

  def remove_dirs(parent_directory=nil, names=[])
  	Dir.chdir(parent_directory) do
  		names.each do |name|
  			FileUtils.rm_r(name) if Dir.exists?(name)
  		end
  	end
  end
end
