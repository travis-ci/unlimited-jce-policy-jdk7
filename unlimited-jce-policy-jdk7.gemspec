# vim:fileencoding=utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'unlimited/jce/policy/jdk7/version'

Gem::Specification.new do |spec|
  spec.name        = 'unlimited-jce-policy-jdk7'
  spec.version     = Unlimited::Jce::Policy::Jdk7::VERSION
  spec.authors     = ['Dan Buch']
  spec.email       = ['dan@travis-ci.com']
  spec.summary     = %q{It's JCE Unlimited Strength Jurisdiction Policy Files 7 in a gem!}
  spec.description = spec.summary
  spec.license     = 'All Rights Reserved'

  # Disable publishing to rubygems mkay
  spec.metadata['allowed_push_host'] = 'https://nonexistent-host.example.com'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler', '~> 1.7'
  spec.add_development_dependency 'rake', '~> 10.0'
end
