require 'rubygems'
require 'rake'

begin
  require 'ore/tasks'
  Ore::Tasks.new
rescue LoadError => e
  STDERR.puts e.message
  STDERR.puts "Run `gem install ore-tasks` to install 'ore/tasks'."
end

begin
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new
rescue LoadError => e
  task :spec do
    abort "Please run `gem install rspec` to install RSpec."
  end
end
task :default => :spec

begin
  require 'yard'
  YARD::Rake::YardocTask.new  
rescue LoadError => e
  task :yard do
    abort "Please run `gem install yard` to install YARD."
  end
end
