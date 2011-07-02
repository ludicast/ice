# Configure Rails Envinronment
ENV["RAILS_ENV"] = "test"

require File.expand_path("../dummy/config/environment.rb",  __FILE__)
require "rails/test_help"
require "rspec/rails"

Note.delete_all

ActionMailer::Base.delivery_method = :test
ActionMailer::Base.perform_deliveries = true
ActionMailer::Base.default_url_options[:host] = "test.com"

require File.dirname(__FILE__) + "/../lib/ice"
require "informal"

require "capybara/rails" 
Rails.backtrace_cleaner.remove_silencers! 
Capybara.default_driver = :rack_test
Capybara.default_selector = :css

# Run any available migration
ActiveRecord::Migrator.migrate File.expand_path("../dummy/db/migrate/", __FILE__)

# Load support files
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  # Remove this line if you don't want RSpec's should and should_not
  # methods or matchers
  require 'rspec/expectations'
  config.include RSpec::Matchers

  # == Mock Framework
  config.mock_with :rspec
end


class FooClassCube < Ice::BaseCube
  revealing :first, :second
end

class FooClass
  include Ice::Cubeable
  include ActiveModel::Serialization
  
  attr_accessor :attributes
  
  def initialize(attributes = {})
    @attributes = attributes
  end
  
  def first
    "primero"
  end

  def second
    @second ||= SecondClass.new
  end
end

class SecondClass
  def to_ice
    "segundo"
  end
end
 

describe "BaseCube" do
  context "a cubeable class" do
    it "should automatically to_ice the cube_class" do
      FooClass.new.to_ice.class.should == FooClassCube
    end

    it "should retrieve revealed properties" do
      FooClass.new.to_ice.first.should == "primero"
    end

    it "should map revealed properties via to_ice" do
      FooClass.new.to_ice.second.should == "segundo"
    end
  end
end

def mock_out_enumerable_each(object, *items)
  block = lambda {|block| items.each{|n| block.call(n)}}
  object.stub!(:each).and_return(&block)
end