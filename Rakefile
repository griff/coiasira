# Rakefile for Coiasira.  -*-ruby-*-
require 'rake/rdoctask'
require 'rake/testtask'
require File.join(File.dirname(__FILE__), 'lib', 'coiasira', 'version')

desc "Default Task"
task :default => [:package]

desc "Do predistribution stuff"
task :predist => [:chmod, :rdoc]


desc "Make an archive as .tar.gz"
task :dist => [:test, :predist] do
  sh "git archive --format=tar --prefix=#{release}/ HEAD^{tree} >#{release}.tar"
  sh "pax -waf #{release}.tar -s ':^:#{release}/:' RDOX doc"
  sh "gzip -f -9 #{release}.tar"
end

desc "Make binaries executable"
task :chmod do
  Dir["bin/*"].each { |binary| File.chmod(0775, binary) }
  Dir["test/cgi/test*"].each { |binary| File.chmod(0775, binary) }
end

desc "Run all the tests"
task :test => [:chmod] do
  sh "specrb -Ilib:test -w #{ENV['TEST'] || '-a'} #{ENV['TESTOPTS']}"
end

def gem_version
  Coiasira::VERSION::STRING
end

def release
  "coiasira-#{gem_version}"
end

def manifest
  `svn ls -R`.split("\n")
end

task :install => [:gem] do
  sh "gem install pkg/#{release}.gem"
end

begin
  require 'rubygems'

  require 'rake'
  require 'rake/clean'
  require 'rake/packagetask'
  require 'rake/gempackagetask'
  require 'fileutils'
rescue LoadError
  # Too bad.
else
  spec = Gem::Specification.new do |s|
    s.name            = "coiasira"
    s.version         = gem_version
    s.platform        = Gem::Platform::RUBY
    s.summary         = "some helpers for running scheduled jobs"

    s.description = <<-EOF
Something, something.

Also see http://coiasira.rubyforge.org.
    EOF

    s.files           = manifest + %w(RDOX)
    s.bindir          = 'bin'
    s.executables     << 'coiasira'
    s.require_path    = 'lib'
    s.has_rdoc        = true
    s.extra_rdoc_files = ['README', 'RDOX']
    s.test_files      = Dir['test/{test,spec}_*.rb']

    s.author          = 'Nigel Graham'
    s.email           = 'nigel@maven-group.org'
    s.homepage        = 'http://coiasira.rubyforge.org'
    s.rubyforge_project = 'coiasira'

    s.add_dependency('activesupport', '= 2.1.0')
  end

  Rake::GemPackageTask.new(spec) do |p|
    p.gem_spec = spec
    p.need_tar = true
    p.need_zip = true
  end
end

desc "Generate RDox"
task "RDOX" do
  sh "specrb -Ilib:test -a --rdox >RDOX"
end

desc "Generate RDoc documentation"
Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.options << '--line-numbers' << '--inline-source' <<
    '--main' << 'README' <<
    '--title' << 'Coiasira Documentation' <<
    '--charset' << 'utf-8'
  rdoc.rdoc_dir = "doc"
  rdoc.rdoc_files.include 'README'
  rdoc.rdoc_files.include 'KNOWN-ISSUES'
  rdoc.rdoc_files.include 'RDOX'
  rdoc.rdoc_files.include('lib/quartz.rb')
  rdoc.rdoc_files.include('lib/quartz/*.rb')
  rdoc.rdoc_files.include('lib/quartz/*/*.rb')
end
task :rdoc => ["RDOX"]
