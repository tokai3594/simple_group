lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'simple_group/version'

Gem::Specification.new do |spec|
  spec.name          = "simple_group"
  spec.version       = SimpleGroup::VERSION
  spec.authors       = ["Toyoaki Oko"]
  spec.email         = ["chariderpato@gmail.com"]

  spec.summary       = %q{simple_group is able to add group function to ActiveRecord.}
  spec.description   = %q{simple_group is able to add group function to ActiveRecord.}
  spec.homepage      = "https://github.com/patorash/simple_group"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", ">= 3.0.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "database_rewinder", "~> 0.5.1"
  spec.add_development_dependency 'combustion', '~> 0.5.3'
end
