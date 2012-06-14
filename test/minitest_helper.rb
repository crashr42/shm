require "minitest/autorun"
require "minitest/rails"
require "minitest/pride"

ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require 'minitest/reporters'
MiniTest::Unit.runner = MiniTest::SuiteRunner.new
MiniTest::Unit.runner.reporters << MiniTest::Reporters::RubyMineReporter.new

class MiniTest::Rails::Spec
  # Add methods to be used by all specs here
end

class MiniTest::Rails::Model
  # make fixtures available within models spec
  include MiniTest::Rails::Fixtures
end

class MiniTest::Rails::Controller
  # Add methods to be used by controller specs here
end

class MiniTest::Rails::Helper
  # Add methods to be used by helper specs here
end

class MiniTest::Rails::Mailer
  # Add methods to be used by mailer specs here
end

class MiniTest::Rails::Integration
  # Add methods to be used by integration specs here
end