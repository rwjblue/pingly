# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pinger'

Gem::Specification.new do |gem|
  gem.name          = "pinger"
  gem.version       = Pinger::VERSION
  gem.authors       = ["Jon Jackson", "Robert Jackson"]
  gem.email         = ["robertj@promedicalinc.com"]
  gem.description   = %q{Ping a specified host, logs the output, and calls a block on packet loss.}
  gem.summary       = %q{Ping a specified host.}
  gem.homepage      = "https://github.com/rjackson/pinger"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
