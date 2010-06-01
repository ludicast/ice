
describe 'path_helper'
  before_each
    user = {id:1, class_path:'users'}
  end

  describe 'for paths'
    it "should generate view path from item"
      view_path(user).should.eql "/users/1"
    end

    it "should generate edit path from item"
      edit_path(user).should.eql "/users/1/edit"
    end
  end

  describe "for links"
    describe "without parameters"
      it "should generate view link from item"
        view_link(user).should.eql "<a href=\"/users/1\">View</a>"
      end
      it "should generate edit link from item"
        edit_link(user).should.eql "<a href=\"/users/1/edit\">Edit</a>"
      end
      it "should generate index link"
        index_link(user.class_path).should.eql "<a href=\"/users\">List</a>"
      end
    end


    describe "with parameters"
      it "should generate view link from item"
        view_link(user, {label:"See Info"}).should.eql "<a href=\"/users/1\">See Info</a>"
      end
      it "should generate edit link from item"
        edit_link(user, {label:"Change Info"}).should.eql "<a href=\"/users/1/edit\">Change Info</a>"
      end
      it "should generate edit link from item"
        index_link(user.class_path, {label:"All Users"}).should.eql "<a href=\"/users\">All Users</a>"
      end
    end

  end


end
