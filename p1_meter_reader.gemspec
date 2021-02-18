# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'p1_meter_reader/version'

Gem::Specification.new do |spec|
  spec.name          = "p1_meter_reader"
  spec.version       = P1MeterReader::VERSION
  spec.authors       = ["Lennaert Meijvogel"]
  spec.email         = ["l.meijvogel@yahoo.co.uk"]

  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com' to prevent pushes to rubygems.org, or delete to allow pushes to any server."
  end

  spec.summary       = %q{Read data from a compatible P1 smart meter}
  spec.description   = %q{This is a library that reads and returns all (known) measurements that are returned by the P1 smart meter as used in the Netherlands.}
  spec.homepage      = "https://github.com/lmeijvogel/p1_meter_reader_gem"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "serialport", "1.3.1"

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", ">= 12.3.3"
end
