Gem::Specification.new do |s|
  s.name = %q{linkscape}
  s.version = "0.2.1"
  s.date = %q{2010-02-02}
  s.authors = ["Marty Smyth", "Jeff Pollard"]
  s.email = %q{api@seomoz.org}
  s.summary = %q{Provides an interface to the SEOmoz API}
  s.homepage = %q{}
  s.description = %q{Provides an interface to SEOmoz's suite of APIs, including the free and site intelligence APIs.}
  s.files = [
    "README.rdoc",
    "LICENSE",
    "lib/hash-ext.rb",
    "lib/linkscape/client.rb",
    "lib/linkscape/constants/anchor-metrics.rb",
    "lib/linkscape/constants/link-metrics.rb",
    "lib/linkscape/constants/url-metrics.rb",
    "lib/linkscape/constants.rb",
    "lib/linkscape/errors.rb",
    "lib/linkscape/request.rb",
    "lib/linkscape/response.rb",
    "lib/linkscape/signer.rb",
    "lib/linkscape.rb",
    "lib/string-ext.rb",
    "rails/init.rb",
  ]
end