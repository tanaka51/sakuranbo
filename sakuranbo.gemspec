# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sakuranbo/version'

Gem::Specification.new do |spec|
  spec.name          = "sakuranbo"
  spec.version       = Sakuranbo::VERSION
  spec.authors       = ["Koichi TANAKA"]
  spec.email         = ["tanaka51.jp@gmail.com"]
  spec.description   = %q{Add 'lazy_update' option to has_many}
  spec.summary       = %q{Add 'lazy_update' option to has_many}
  spec.homepage      = "https://github.com/tanaka51-jp/sakuranbo"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "activerecord"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "pry"
end
