require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:development, :doc)
rescue Bundler::BundlerError => e
  STDERR.puts e.message
  STDERR.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'rake'
require 'jeweler'

Jeweler::Tasks.new do |gem|
  gem.name = 'digest-crc'
  gem.license = 'MIT'
  gem.summary = %Q{A Cyclic Redundancy Check (CRC) library for Ruby.}
  gem.description = %Q{Adds support for calculating Cyclic Redundancy Check (CRC) to the Digest module.}
  gem.email = 'postmodern.mod3@gmail.com'
  gem.homepage = 'http://github.com/postmodern/digest-crc'
  gem.authors = ['Postmodern']
  gem.add_development_dependency 'rspec', '>= 1.3.0'
  gem.has_rdoc = 'yard'
end

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new
task :default => :spec

require 'yard'
YARD::Rake::YardocTask.new
