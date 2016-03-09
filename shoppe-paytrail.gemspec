# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'shoppe/paytrail/version'

Gem::Specification.new do |spec|
  spec.name          = 'shoppe-paytrail'
  spec.version       = Shoppe::Paytrail::VERSION
  spec.authors       = ['Joakim Antman']
  spec.email         = ['antmanj@gmail.com']

  spec.summary       = 'Shoppe module for handling Paytrail integration'
  spec.homepage      = 'https://github.com/anakinj/shoppe-paytrail'
  spec.license       = 'MIT'

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  else
    raise 'RubyGems 2.0 or newer is required to protect against public gem pushes.'
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'shoppe', '> 1', '< 2'
  spec.add_dependency 'paytrail-client'

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
