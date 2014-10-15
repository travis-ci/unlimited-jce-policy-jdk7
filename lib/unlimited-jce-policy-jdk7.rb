require_relative 'unlimited/jce/policy/jdk7'
Unlimited::Jce::Policy::Jdk7.init if RUBY_PLATFORM == 'java'
