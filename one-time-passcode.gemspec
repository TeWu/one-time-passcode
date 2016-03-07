# coding: utf-8

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'one-time-passcode/version'

Gem::Specification.new do |s|
  s.name          = "one-time-passcode"
  s.version       = OneTimePasscode::VERSION
  s.authors       = ["Tomasz Więch"]
  s.email         = ["tewu.dev@gmail.com"]
  
  s.summary       = "Simple one-time passcode generator"
  s.homepage      = "https://github.com/TeWu/one-time-passcode"
  s.license       = "MIT"
  
  s.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(doc|test|spec|features)/}) || f.start_with?('.') }
  s.require_paths = ["lib"]
  
  s.required_ruby_version = ">= 2.1.0"

  s.add_runtime_dependency "base32", "~> 0.3"
end
