# Rakefile for Coiasira.  -*-ruby-*-
require 'bundler'

def install_tasks(opts = nil)
  dir = caller.find{|c| /Rakefile:/}[/^(.*?)\/Rakefile:/, 1]
  h = Bundler::GemHelper.new(dir, opts && opts[:name])
  h.install
  h
end
helper = install_tasks
spec = helper.gemspec

require 'rake/clean'
CLEAN.include 'pkg'

task :git_local_check do
  sh "git diff --no-ext-diff --ignore-submodules --quiet --exit-code" do |ok, _|
    raise "working directory is unclean" if !ok
    sh "git diff-index --cached --quiet --ignore-submodules HEAD --" do |ok, _|
      raise "git index is unclean" if !ok
    end
  end
end


require 'rake/rdoctask'
Rake::RDocTask.new do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "#{spec.name} #{spec.version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end


#require 'rake/rdoctask'
#require 'rake/testtask'
#require File.join(File.dirname(__FILE__), 'lib', 'coiasira', 'version')

#desc "Default Task"
#task :default => [:package]

#desc "Do predistribution stuff"
#task :predist => [:chmod, :rdoc]


#desc "Make an archive as .tar.gz"
#task :dist => [:test, :predist] do
#  sh "git archive --format=tar --prefix=#{release}/ HEAD^{tree} >#{release}.tar"
#  sh "pax -waf #{release}.tar -s ':^:#{release}/:' RDOX doc"
#  sh "gzip -f -9 #{release}.tar"
#end

#desc "Make binaries executable"
#task :chmod do
#  Dir["bin/*"].each { |binary| File.chmod(0775, binary) }
#  Dir["test/cgi/test*"].each { |binary| File.chmod(0775, binary) }
#end

#desc "Run all the tests"
#task :test => [:chmod] do
#  sh "specrb -Ilib:test -w #{ENV['TEST'] || '-a'} #{ENV['TESTOPTS']}"
#end

#def gem_version
#  Coiasira::VERSION::STRING
#end

#def release
#  "coiasira-#{gem_version}"
#end

#def manifest
#  `svn ls -R`.split("\n")
#end

#task :install => [:gem] do
#  sh "gem install pkg/#{release}.gem"
#end

