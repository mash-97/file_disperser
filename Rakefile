require "bundler/gem_tasks"
require "rake/testtask"
require "rake/clean"

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

task :test => ["clean:test_base", :stand_test_base]
task :default => :test

desc "create test_base inside test directory"
task(:stand_test_base) do
  puts("\nstand_test_base: running")
  path = File.join("test", "test_base")

  FileUtils.mkdir(path) if not Dir.exist?(path)
  puts("status: #{Dir.exist?(path)}")
  puts("stand_test_base: complete")
  puts("\n")
end

namespace :show do
  task :test_base do
  end
end
namespace :clean do
  task :test_base do
    puts("clean:test_base :: running")
    path = File.join("test", "test_base")
    FileUtils.rm_r(Dir["#{path}/*"], verbose: true)
    # FileUtils.mkdir(path) if Dir.exist?(path)
    puts("clean:test_base :: complete")
  end
end
