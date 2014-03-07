#!/usr/bin/env gem build
# encoding: utf-8

require File.expand_path("../lib/padrino-pipeline/version.rb", __FILE__)
require File.expand_path("../lib/padrino-pipeline/tasks.rb", __FILE__)

Gem::Specification.new do |s|
  s.name = "padrino-pipeline"
  s.rubyforge_project = "padrino-pipeline"
  s.authors = ["Sumeet Singh"]
  s.email = "ortuna@gmail.com"
  s.summary = "The Padrino asset management system"
  s.homepage = "http://www.padrinorb.com"
  s.description = "The Padrino asset management system allowing frictionless serving of assets"
  s.required_rubygems_version = ">= 1.3.6"
  s.version = Padrino::Pipeline::VERSION
  s.date = Time.now.strftime("%Y-%m-%d")

  s.extra_rdoc_files = Dir["*.rdoc"]
  s.files         = `git ls-files`.split("\n") | Dir.glob("{lib}/**/*")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
  s.rdoc_options  = ["--charset=UTF-8"]

  s.add_dependency("padrino-core", ">= 0.11")
  s.add_dependency("padrino-helpers", ">= 0.11")
  s.add_dependency("coffee-script", "~> 2.2.0")
  s.add_dependency("sass", "~> 3.2.0")
  s.add_dependency("uglifier", "~> 2.1")
  
  s.add_dependency("sprockets", "~> 2.11")
  s.add_dependency("sinatra-assetpack", "~> 0.3.0")
end
