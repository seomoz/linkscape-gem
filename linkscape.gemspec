Gem::Specification.new do |s|
  s.name = %q{linkscape}
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Martin Tithonium", "Jeff Pollard", "Bryce Howard"]
  s.date = %q{2012-12-12}
  s.description = %q{Provides an interface to SEOmoz's suite of APIs, including the free and site intelligence APIs.}
  s.email = %q{api@seomoz.org}
  s.homepage = %q{http://github.com/seomoz/linkscape-gem}
  s.summary = %q{Provides an interface to the SEOmoz API}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency(%q<ruby-hmac>, [">= 0"])
  s.add_dependency(%q<faraday>, ["~> 0.8.1"])
  s.add_dependency(%q<faraday_middleware>, [">= 0.8.8"])
end

