unless RUBY_PLATFORM == 'java'
  require 'simplecov'
  SimpleCov.formatter = SimpleCov::Formatter::HTMLFormatter

  SimpleCov.start do
    project_name 'unlimited-jce-policy-jdk7'
    coverage_dir '.coverage'
    add_filter '/spec/'
    add_group 'Library', 'lib'
  end
end
