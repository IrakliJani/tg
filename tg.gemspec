# -*- encoding: utf-8 -*-

require File.expand_path("../lib/tg/version", __FILE__)

Gem::Specification.new do |s|
	s.authors       = ["Irakli Janiashvili"]
	s.email         = ["irakli.janiashvili@gmail.com"]
	s.description   = %q{eng → geo and geo → eng translator using translate.ge api}
	s.summary       = %q{simple CLI tool}
	s.homepage      = "http://github.com/irakli-janiashvili/tg"

	s.bindir = "bin"
	s.executables = "tg"

	s.add_dependency "json"
	s.add_dependency "rainbow"
	s.add_dependency "rb-readline"

	s.files = %w{LICENSE README.md Rakefile Gemfile tg.gemspec}
	s.files += Dir.glob("lib/**/*.rb")
	s.files += Dir.glob("bin/**/*")

	s.name          = "tg"
	s.require_paths = ["lib"]
	s.version       = Tg::VERSION
end
