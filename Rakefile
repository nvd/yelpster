# encoding: UTF-8

require 'bundler'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
task :default => :spec

desc 'Run the specs'
RSpec::Core::RakeTask.new(:spec) do |t|
  t.pattern = 'spec/**/*_spec.rb'
  t.verbose = true
end
