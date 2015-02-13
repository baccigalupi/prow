# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'prow/version'

Gem::Specification.new do |spec|
  spec.name          = "prow"
  spec.version       = Prow::VERSION
  spec.authors       = ["Kane Baccigalupi"]
  spec.email         = ["baccigalupi@gmail.com"]
  spec.summary       = %q{Prow is a front end development framework, that can also server static websites}
  spec.description   = %q{
    Prow is solving the problem front-end developers have when they try to
    start a project, and need a server mock to work with. It also solves the
    problem of creating and serving a static HTML/CSS/JS that includes heavy
    front-end development work.

    Prow includes:
      * Mustache to HTML file generation
      * ShipdStyle compass plugin for getting easy responsive design widgets
      * DeMedusa the slim, extensible, JS framework
  }
  spec.homepage      = "https://github.com/shipd/prow"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "shipd_style"
  spec.add_dependency "mustache"
  spec.add_dependency "vienna"
  spec.add_dependency "inotify"

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rake"
end
