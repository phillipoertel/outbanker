require "bundler/gem_tasks"
require "rake/testtask"

task :default => :test

Rake::TestTask.new do |t|
   t.libs << "test"
   t.test_files = FileList['test/outbanker/**/*_test.rb']
   t.verbose = true
end

desc 'parse a file given as FILE for testing purposes, show the FIELDS given on the cli'
task :parse_file do
  require 'outbanker'
  require 'yaml'
  file = ENV['FILE']
  fields = ENV['FIELDS'].split(',')
  Outbanker::StatementLines.read(file).each do |line|
    puts fields.map { |f| "#{f}: #{line.send(f)}" }.join("\n")
  end
end
