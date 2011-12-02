require 'rubygems'
require 'spork'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  #require File.expand_path("../../config/boot", __FILE__)
  #Spork.trap_method(Rails::Initializer, :load_application_classes)
  require File.expand_path("../../config/environment", __FILE__)

  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.include Devise::TestHelpers, :type => :controller
    config.mock_with :rspec
    config.use_transactional_fixtures = true
  end
end

Spork.each_run do
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
end
