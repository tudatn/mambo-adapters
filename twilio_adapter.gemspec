# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "twilio_adapter/version"

Gem::Specification.new do |s|
  s.name        = "mambo-twilio_adapter"
  s.version     = TwilioAdapter::VERSION
  s.authors     = ["Chris Dion"]
  s.email       = ["chris@verticallabs.ca"]
  s.homepage    = ""
  s.summary     = %q{Twilio Adapter}
  s.description = %q{Twilio Adapter}

  s.rubyforge_project = "mambo-twilio_adapter"

	s.files = Dir["{app,config,lib}/**/*"] + ["Rakefile"]

  # specify any dependencies here; for example:
	s.add_runtime_dependency "rails"
  s.add_runtime_dependency "twilio-rb"
  s.add_runtime_dependency "mambo-sms"
  s.add_runtime_dependency "mambo-support"
  
  s.add_development_dependency "rspec-rails"
	s.add_development_dependency "factory_girl"
	s.add_development_dependency "combustion"
  s.add_development_dependency "magic_encoding"
end
