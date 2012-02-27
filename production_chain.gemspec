Gem::Specification.new do |s|
  s.name              = "production_chain"
  s.version           = "0.0.1"
  s.platform          = Gem::Platform::RUBY
  s.authors           = ["Novelys"]
  s.email             = ["contact@novelys.com"]
  s.homepage          = "http://github.com/novelys/production_chain"
  s.summary           = "Production Chain"
  s.description       = "Production Chain blah"
  s.rubyforge_project = s.name
 
  s.required_rubygems_version = ">= 1.3.6"
 
  s.files         = `git ls-files`.split("\n")
  # s.executables   = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  # s.extensions    = `git ls-files ext/extconf.rb`.split("\n")
 
  s.require_path = 'lib'
 
  # For C extensions
  # s.extensions = "ext/extconf.rb"
end