require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "PathHelper" do
  before do
    user_class = Class.new do
      def id
        1
      end

      def class_path
        'users'
      end

      def to_ice
        self
      end
    end
    @user = user_class.new
  end


  it "should generate link from item" do
    Ice.convert_template(%{<%= view_path(me) %>}, {'me' => @user} ).should == "/users/1"
  end
  
end