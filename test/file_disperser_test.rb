require "test_helper"

class FileDisperserTest < Minitest::Test
  def test_that_it_has_a_version_number
    refute_nil ::FileDisperser::VERSION
  end

  def test_it_does_something_useful
    assert FileDisperser::FileDisperser.new
  end

  def test_folder_generator()
    $mashz_log.level = Logger::WARN
    dest_dir_path = File.join(File.absolute_path(File.dirname(__FILE__)), "test_base/folder_gen_test")

    dl = 20
    dr = (5..10)
    f = FileDisperser::FolderGenerator.new(dest_dir_path, limits: {:dispersion_range=>dr, :depth_limit=>dl})
    assert(f.limits[:depth_limit]==dl)
    assert(f.limits[:dispersion_range]==dr)

    begin
      Timeout.timeout(10) do
        total_dirs = f.gen_folders()
        $fdspsr_log.info("Total Directories Created: #{total_dirs}")
      end
    rescue => exception
      $fdspsr_log.info("Timeout: #{exception}")
    end

    assert Dir[dest_dir_path+"/**"].length != 0
    $fdspsr_log.info("Show generated tree using tty-tree: \n")
    tree  = TTY::Tree.new(dest_dir_path, only_dirs: true)
    puts(tree.render(as: :dir, indent: 3))

  end

end
