require File.dirname(__FILE__) + '/spec_helper'

describe "to_ice" do
  context "when there exists a active model without a to_ice method on it" do
    before do
      @my_class = Class.new do
        include ActiveModel::Serialization
      end
    end

    specify {
      expect { @my_class.new.to_ice }.to raise_error "Cannot find Cube class for model that you are calling to_ice on." }

  end

end