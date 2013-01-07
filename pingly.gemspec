# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pingly'

Gem::Specification.new do |gem|
  gem.name                  = "pingly"
  gem.version               = Pingly::VERSION
  gem.authors               = ["Jon Jackson", "Robert Jackson"]
  gem.email                 = ["robertj@promedicalinc.com"]
  gem.description           = %q{Ping a specified host, logs the output, and calls a block on packet loss.}
  gem.summary               = %q{Ping a specified host.}
  gem.homepage              = "https://github.com/rjackson/Pingly"
  gem.required_ruby_version = '>= 1.9.2'

  gem.files                 = `git ls-files`.split($/)
  gem.executables           = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files            = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths         = ["lib"]
end
