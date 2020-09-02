require "bundler/gem_tasks"
require "rake/testtask"
require "rake/clean"
require "tty-tree"

require_relative "test/test_helper"
Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :test => ["clean:test_base", "clean:assets", "check:assets", "check:test_base"]
task :default => :test



namespace :show do
  task :test_base do
    tree = TTY::Tree.new(TestHelper::TEST_BASE_PATH)
    puts(tree.render)
  end
  task :assets do
    tree = TTY::Tree.new(TestHelper::ASSETS_PATH)
    puts(tree.render)
  end

  task :load_paths do
    puts($LOAD_PATH)
  end
end

namespace :check do
  task :assets do
    puts("Checking #{TestHelper::ASSETS_PATH}")
    if not Dir.exist?(TestHelper::ASSETS_PATH) then
      puts("Doesn't exist, so creating one!")
      FileUtils.mkdir(TestHelper::ASSETS_PATH)
      puts("Created!")
    else
      puts("Exists!")
    end
  end

  task(:test_base) do
    puts("Checking #{TestHelper::TEST_BASE_PATH}")
    if not Dir.exist?(TestHelper::TEST_BASE_PATH) then
      puts("Doesn't exist, so creating one!")
      FileUtils.mkdir(TestHelper::TEST_BASE_PATH)
      puts("Created!")
    else
      puts("Exists!")
    end
  end
end

namespace :clean do
  task :test_base do
    puts("clean:test_base :: running")
    FileUtils.rm_r(Dir["#{TestHelper::TEST_BASE_PATH}/*"])
    puts("clean:test_base :: complete")
  end

  task :assets do
    puts("clean:assets :: running")
    FileUtils.rm_r(Dir["#{TestHelper::ASSETS_PATH}/*"])
    puts("clean:assets :: complete")
  end

  task :all => [:test_base, :assets]
end
