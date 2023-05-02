require "rake/testtask"
require 'rdoc/task'


Rake::TestTask.new do |t|
  t.libs << "test"
end

RDoc::Task.new do |rdoc|
  rdoc.main = "README.rdoc"
  rdoc.rdoc_files.include( "README.rdoc", "lib/**/*.rb")
end

desc "Run full build/test/doc process"
task tests_and_docs: [:test, :rdoc]

desc "Run tests"
task default: :test
