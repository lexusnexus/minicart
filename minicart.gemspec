# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "minicart/version"

Gem::Specification.new do |s|
  s.name        = "minicart"
  s.version     = Minicart::VERSION
  s.authors     = ["Alexander Boreysha"]
  s.email       = ["gorizvezda@gmail.com"]
  s.homepage    = ""
  s.summary     = %q{Minimal shopping cart}
  s.description = %q{This is minimal shopping cart w/o dependencies}

  s.rubyforge_project = "minicart"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.require_paths = ["lib"]

  s.extra_rdoc_files = %w[README.rdoc]
  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
