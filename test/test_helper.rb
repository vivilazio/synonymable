$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'synonymable'
# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"

#ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + '/debug.log')
#ActiveRecord::Migration.verbose = false

require 'minitest/autorun'
class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  fixtures :all
end
