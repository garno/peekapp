# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "peekapp/version"

Gem::Specification.new do |s|
  s.name        = "peekapp"
  s.version     = Peekapp::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Samuel Garneau"]
  s.email       = ["samgarneau@gmail.com"]
  s.homepage    = "http://github.com/garno/peekapp"
  s.summary     = %q{Retrieve ratings & reviews from the App Store}
  s.description = %q{Easily scrape the App Store to retrieve ratings & reviews.}

  #s.rubyforge_project = "peekapp"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_dependency('nokogiri', '>= 1.4.4')
  s.add_dependency('json', '>= 1.4.6')
  s.add_dependency('curb', '>= 0.7.9')
end
