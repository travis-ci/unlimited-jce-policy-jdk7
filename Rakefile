require 'bundler/setup'

begin
  require 'rspec/core/rake_task'
  require 'rubocop/rake_task'
rescue LoadError => e
  warn e
end

RuboCop::RakeTask.new if defined?(RuboCop)
RSpec::Core::RakeTask.new if defined?(RSpec)

task :blackbox do
  if RUBY_PLATFORM != 'java'
    puts 'no black box test for you'
    next
  end
  sh 'examples/sinatra-app/black-box-test'
end

task default: [:rubocop, :spec, :blackbox]
