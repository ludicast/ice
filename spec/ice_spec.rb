require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe "Ice" do

  it "converts a javascript template to html" do
    Ice.convert_template("<%= 'hello world' %>").should == "hello world"
  end

  it "takes variables as syms" do
    vars = {:hola => "hello", :mundo => "world" }
    Ice.convert_template("<%= hola + ' ' + mundo %>", vars).should == "hello world"
  end

  it "takes variables as string" do
    vars = {'hola' => "hello", 'mundo' => "world" }
    Ice.convert_template("<%= hola + ' ' + mundo %>", vars).should == "hello world"
  end

  it "takes booleans, strings, and numbers as their value" do
    vars = {'integer' => 1, 'float' => 1.1, 'boolean' => true, 'string' => "String"}
    Ice.convert_template('<%= integer + " " + float + " " + boolean + " " + string %>',
      vars).should == "1 1.1 true String"
  end

  context "to_ice function" do
    it "should allow identical values for true" do
      true.to_ice.should == true
    end

    it "should allow identical values for false" do
      false.to_ice.should == false
    end

    it "should allow identical values for integer" do
      1.to_ice.should == 1
    end

    it "should allow identical values for float" do
      1.1.to_ice.should == 1.1
    end

    it "should allow identical values for string" do
      "hi".to_ice.should == "hi"
    end

    it "should default to nil for an object" do
      Object.new.to_ice.should be_nil
    end
    context "for array" do
      it "should freeze elements of array" do
        i = []
        i.should_receive(:to_ice)
        [i].to_ice
      end
      it "should return array" do
        array = [1, "foo"]
        array.to_ice.should == [1, "foo"]
      end
      it "should pass in array with details" do
        pending "waiting for V8 engine to support passing in arrays"
        myarray = ["one", "two", "three"]
        vars = {"myarray" => myarray }
        Ice.convert_template(%{<% for (var i = 0; i < myarray.length; i++) { %><p><%= myarray[i] %></p><% } %>},
          vars).should == "<p>one</p><p>two</p><p>three</p>"

      end

    end
    context "for hash" do
      it "should freeze elements of array" do
        i = []
        i.should_receive(:to_ice)
        {:var => i}.to_ice
      end
      it "should return hash" do
        hash = {"foo" => 1}
        hash.to_ice.should == {"foo" => 1}
      end
    end

    it "should run to_ice on variables" do
      message = Object.new
      def message.to_ice
        "hello world"
      end

      vars = {'message' => message }
      Ice.convert_template("<%= message %>", vars).should == "hello world"
    end
  end


end
