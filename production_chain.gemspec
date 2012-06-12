$:.unshift File.expand_path('../lib', __FILE__)
require 'production_chain/version'

Gem::Specification.new do |s|
  s.name              = "production_chain"
  s.version           = ProductionChain::VERSION
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Novelys"]
  s.email             = ["contact@novelys.com"]
  s.homepage          = "http://github.com/novelys/production_chain"
  s.summary           = "Production Chain"
  s.description       = "A rails plugin that incorporate various libs, recipes and tasks"
  s.rubyforge_project = s.name

  s.required_rubygems_version = ">= 1.3.6"

  s.files         = `git ls-files`.split("\n")

  s.require_path = 'lib'
end