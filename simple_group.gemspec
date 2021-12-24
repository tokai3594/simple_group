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
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6.0")

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord", '< 7.1.0', '>= 5.0.0'
  spec.add_dependency "activesupport", '< 7.1.0', '>= 5.0.0'
  spec.add_dependency "railties", '< 7.1.0', '>= 5.0.0'
  spec.add_development_dependency 'rake', '>= 12.3.3'
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency 'database_cleaner', '~> 2.0'
end
