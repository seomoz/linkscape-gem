# -*- encoding: utf-8 -*-
$LOAD_PATH << File.expand_path("../lib", __FILE__)
require "linkscape/version"

Gem::Specification.new do |s|
  s.name        = "linkscape"
  s.version     = Linkscape::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Martin Tithonium", "Jeff Pollard", "Bryce Howard"]
  s.email       = ["api@seomoz.org"]
  s.homepage    = "http://github.com/seomoz/linkscape-gem"
  s.summary     = "Provides an interface to the SEOmoz API"
  s.description = "Provides an interface to SEOmoz's suite of APIs, including the free and site intelligence APIs."

  s.add_dependency "ruby-hmac"
  s.add_dependency "activeresource", ["~> 3.0.0"]
  s.add_dependency "will_paginate", ["~> 2.3"]
  s.add_development_dependency "rspec"
  s.add_development_dependency "fakeweb"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
