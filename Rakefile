# coding:utf-8
RAKE_ROOT = __FILE__

require 'rubygems' unless defined?(Gem)
require 'rake'
require 'rake/testtask'
require 'bundler/gem_tasks'
Rake::TestTask.new(:test) do |test|
  test.libs << 'test'
  test.test_files = Dir['test/**/test_*.rb']
  test.verbose = true
end

task :default => :test
