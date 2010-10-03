require File.dirname(__FILE__) + '/spec_helper'

class FooClassCube < Ice::BaseCube
  revealing :first, :second
end

class FooClass
  include Ice::Cubeable

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