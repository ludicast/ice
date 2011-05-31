require File.dirname(__FILE__) + '/spec_helper'
require File.dirname(__FILE__) + "/../lib/ice"
require "informal"
#require "capybara/rails" 
#Rails.backtrace_cleaner.remove_silencers! 
#Capybara.default_driver = :rack_test 


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