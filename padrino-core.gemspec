#!/usr/bin/env gem build
# encoding: utf-8

require File.expand_path("../../padrino-core/lib/padrino-core/version.rb", __FILE__)

Gem::Specification.new do |s|
  s.name = "padrino-assets"
  s.rubyforge_project = "padrino-assets"
  s.authors = ["Padrino Team", "Sumeet Singh"]
  s.email = "padrinorb@gmail.com"
  s.summary = "The Padrino asset management system"
  s.homepage = "http://www.padrinorb.com"
  s.description = "The Padrino asset management system allowing frictionless serving of assets"
  s.required_rubygems_version = ">= 1.3.6"
  s.version = Padrino.version
  s.date = Time.now.strftime("%Y-%m-%d")

  s.extra_rdoc_files = Dir["*.rdoc"]
  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.rdoc_options  = ["--charset=UTF-8"]

  s.add_dependency("coffee-script", "~> 2.2.0")
  s.add_dependency("sprockets", "~> 2.2.0")
  s.add_dependency("uglifier", "~> 2.1.0")
end
