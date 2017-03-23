# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ifqar/version'

Gem::Specification.new do |spec|
  spec.name          = 'ifqar'
  spec.version       = Ifqar::VERSION
  spec.authors       = ['Christian Hein']
  spec.email         = ['chrishein@gmail.com']

  spec.summary       = 'Argentina Investment Funds Quotess client.'
  spec.description   = 'Get quotes for Investment Funds in Argentina from cafci.org.ar.'
  spec.homepage      = 'https://github.com/chrishein/ifqar'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'rest-client', '~> 2.0', '>= 2.0.1'
  spec.add_dependency 'nokogiri', '~> 1.6', '>= 1.6.8'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'vcr', '~> 3.0', '>= 3.0.3'
  spec.add_development_dependency 'webmock', '~> 2.3', '>= 2.3.2'
end
