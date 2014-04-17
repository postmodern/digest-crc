require 'rubygems'
require 'bundler'

Bundler.require :development

require 'rspec/core/rake_task'

Gem::Tasks.new

RSpec::Core::RakeTask.new
task :test => :spec
task :default => :spec

YARD::Rake::YardocTask.new
