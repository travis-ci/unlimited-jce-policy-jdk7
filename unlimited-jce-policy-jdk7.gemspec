# vim:fileencoding=utf-8

Gem::Specification.new do |spec|
  spec.name        = 'unlimited-jce-policy-jdk7'
  spec.version     = '0.1.0'
  spec.authors     = ['Dan Buch']
  spec.email       = ['dan@travis-ci.com']
  spec.summary     = 'JCE Unlimited Strength Jurisdiction Policy Files 7 gem!'
  spec.description = spec.summary
  spec.license     = 'All Rights Reserved'

  # Disable publishing to rubygems mkay
  spec.metadata['allowed_push_host'] = 'https://nonexistent-host.example.com'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(/^bin\//) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(/^(test|spec|features)\//)
  spec.require_paths = %w(lib)

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop'
  spec.add_development_dependency 'simplecov'
end
