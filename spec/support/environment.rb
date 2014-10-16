require 'tmpdir'
require 'fileutils'
require 'unlimited_jce_policy_jdk7'

RSpec.configure do |c|
  c.filter_run focus: true
  c.run_all_when_everything_filtered = true
end
