# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'skybot/version'

Gem::Specification.new do |spec|
  spec.name          = 'skybot'
  spec.version       = Skybot::VERSION
  spec.authors       = ["Alex 'Lexi' Sieberer"]
  spec.email         = ['robotbrain@robotbrain.info']

  spec.summary       = %q{ElrosBot n+1.}
  spec.homepage      = 'https://github.com/robotbrain/SkyBot'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'bin'
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.11'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'jbuilder'
  spec.add_dependency 'cinch', '~> 2.3.2'
  spec.add_dependency 'highline'
  spec.add_dependency 'activesupport'
  spec.add_dependency 'yajl-ruby'
  spec.add_dependency 'git.io', '~> 0.0.5'
  spec.add_dependency 'sinatra'
  spec.add_dependency 'thin'
end
