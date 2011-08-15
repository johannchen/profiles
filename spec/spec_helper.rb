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
    config.mock_with :mocha
    config.use_transactional_fixtures = true
  end
end

Spork.each_run do
  require 'factory_girl'
  FactoryGirl.definition_file_paths = [
    File.join(Rails.root, 'spec', 'factories')
  ]
  FactoryGirl.find_definitions
  ActiveSupport::Dependencies.clear
  ActiveRecord::Base.instantiate_observers
end
