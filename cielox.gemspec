# -*- encoding: utf-8 -*-
require File.expand_path('../lib/cielox/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rafael Souza"]
  gem.email         = ["me@rafaelss.com"]
  gem.description   = %q{Gem for integration with Cielo}
  gem.summary       = %q{Gem for integration with Cielo}
  gem.homepage      = "http://github.com/rafaelss/cielo"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "cielox"
  gem.require_paths = ["lib"]
  gem.version       = Cielox::VERSION

  gem.add_development_dependency "rspec", "~> 2.9.0"
end
