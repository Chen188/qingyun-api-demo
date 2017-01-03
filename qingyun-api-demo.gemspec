# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require './qingyun-api-demo'

Gem::Specification.new do |spec|
  spec.name          = 'qingyun-api-demo'
  spec.version       = QingyunApiDemo.VERSION
  spec.authors       = ['chen188']
  spec.email         = ['fengzhishuiwo@163.com']
  spec.summary       = "qingcloud's api demo."
  spec.description   = 'Some use cases such as create/destroy instance, create/destroy Eip, etc.'
  spec.homepage      = 'https://github.com/Chen188/qingyun-api-demo.git'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '~> 0.10.0'
  spec.add_dependency 'larrow-qingcloud', '~> 0.0.2'
  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake', '~> 0'
end
