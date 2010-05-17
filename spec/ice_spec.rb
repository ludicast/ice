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

end
