require "bundler/gem_tasks"
require "rake/testtask"

task default: :test
Rake::TestTask.new do |t|
  t.libs << "test"
  t.pattern = "test/**/*_test.rb"
  t.warning = false
end

def download_file(file)
  require "open-uri"

  url = "https://github.com/ankane/ml-test-builds/releases/download/vowpalwabbit-8.8.0/#{file}"
  puts "Downloading #{file}..."
  dest = "vendor/#{file}"
  File.binwrite(dest, URI.open(url).read)
  puts "Saved #{dest}"
end

namespace :vendor do
  task :linux do
    download_file("libvw_c_wrapper.so")
  end

  task :mac do
    download_file("libvw_c_wrapper.dylib")
  end

  task :windows do
    download_file("vw_c_wrapper.dll")
  end

  task all: [:linux, :mac, :windows]
end
