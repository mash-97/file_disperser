require "test_helper"

$fdspsr_log.level = Logger::WARN
$mashz_log.level = Logger::WARN
class FileDisperserTest < Minitest::Test
  # FolderGenerator arguments
  DEPTH_LIMIT = 10
  DISPERSION_RANGE = (3..5)

  def test_that_it_has_a_version_number
    refute_nil ::FileDisperser::VERSION
  end

  def test_it_does_something_useful
    assert_raises("ArgumentError") do
      FileDisperser::FileDisperser.new(nil)
    end
  end

  def test_file_disperser()
    $fdspsr_log.info("Running for file_disperser")
    # directory for generating folders and files for testing purpose
    test_dir_path = TestHelper::TEST_BASE_PATH.dup()

    # creating assets using mashz:rfg for source files
    rfg = Mashz::RFG.new(TestHelper::ASSETS_PATH, 10)
    source_files = rfg.run()            # running rfg for 10 files.

    # creating folders structure using FileDisperser::FolderGenerator
    fg = FileDisperser::FolderGenerator.new(test_dir_path)
    fg.gen_folders()


    # dispersing source_files into test_dir_path
    fd = FileDisperser::FileDisperser.new(source_files, test_dir_path)
    copied_files_path = fd.run(20)      # running for 20 uniq copies of each source_files.

    assert(copied_files_path.length  ==  source_files.length*20)
  end

  def test_folder_generator()
    $fdspsr_log.info("Running for folder_generator")
    dest_dir_path = TestHelper::TEST_BASE_PATH.dup()

    dl = 20
    dr = (5..10)
    f = FileDisperser::FolderGenerator.new(dest_dir_path, limits: {:dispersion_range=>dr, :depth_limit=>dl})
    assert(f.limits[:depth_limit]==dl)
    assert(f.limits[:dispersion_range]==dr)

    begin
      Timeout.timeout(10) do
        f.gen_folders().length()
      end
    rescue => exception
      $fdspsr_log.info("Timeout: #{exception}")
    end

    assert( Dir[dest_dir_path+"/**"].length != 0)
  end

end
