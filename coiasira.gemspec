# -*- encoding: utf-8 -*-
require File.expand_path("../lib/coiasira", __FILE__)

Gem::Specification.new do |s|
  s.name        = "coiasira"
  s.version     = Coiasira::VERSION
  s.author      = 'Brian Olsen'
  s.email       = 'brian@maven-group.org'
  s.homepage    = "http://github.com/griff/coaisira"
  s.summary     = "some helpers for running scheduled jobs"
  s.description = "Something something"

  s.required_rubygems_version = ">= 1.3.6"

  s.add_development_dependency "bundler", ">= 1.0.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'

  s.test_files      = Dir['spec/*_spec.rb']

end
