require File.dirname(__FILE__) + '/spec_helper'

class ParentObj
  def to_ice
    "parent"
  end
end

class TagObj
  def to_ice
    @name
  end

  def initialize(name)
    @name = name
  end

end


class ChildModel
  def parent
    @parent ||= ParentObj.new
  end

  def parent_id
    15
  end

  def tags
    @tags ||= [TagObj.new("tag1"), TagObj.new("tag2")]
  end

  def tag_ids
    [1, 2]
  end

  def children
    []
  end

end


class BaseCubeWithBelongsTo
  extend Ice::CubeAssociation

  def initialize
    @source = ChildModel.new
  end

  belongs_to :parent
end

class BaseCubeWithHasMany
  extend Ice::CubeAssociation

  def initialize
    @source = ChildModel.new
  end
  has_many :tags
  has_many :children
end

describe "Cube" do

  context "which has associations" do
    context "when belongs to an item" do

      it "should delegate object calls to its source object" do
        cube = BaseCubeWithBelongsTo.new
        cube.parent.should == "parent"
      end

      it "should delegate id calls to its source object" do
        cube = BaseCubeWithBelongsTo.new
        cube.parent_id.should == 15
      end

    end



    context "when has many of an item" do

      context "for populated collection" do
        it "should delegate object calls to its source object" do
          cube = BaseCubeWithHasMany.new
          cube.tags.should == ["tag1", "tag2"]
        end

        it "should return true from has" do
          cube = BaseCubeWithHasMany.new
          cube.has_tags.should == true
        end

        it "should return tag count" do
          cube = BaseCubeWithHasMany.new
          cube.num_tags.should == 2
        end

        it "should delegate id calls to its source object" do
          cube = BaseCubeWithHasMany.new
          cube.tag_ids.should == [1, 2]
        end
      end

      context "for empty collection" do
        it "should return false from has" do
          cube = BaseCubeWithHasMany.new
          cube.has_children.should == false
        end
      end
    end
  end
end



