require 'rubygems'
require 'v8'

class Object
  def to_ice
    nil
  end
end

[FalseClass, TrueClass, Numeric, String].each do |class_name|
  eval "class #{class_name}
    def to_ice
      puts 'class #{class_name} to_ice'
      self
    end
  end"
end

class Array
  def to_ice
    map &:to_ice
  end
end

class Hash
  def to_ice
    res = {}
    each_pair do |key,value|
      res[key] = value.to_ice
    end
    res
  end
end

module Ice
  def self.convert_template(template_text, vars = {})
    V8::Context::open do |cxt|
      cxt.load "#{File.dirname(__FILE__)}/parser.js"

      vars.each_pair do |key, value|
        cxt[key] = value.to_ice
      end

      cxt['____templateText'] = template_text
      cxt.eval "Jst.evaluate(Jst.compile(____templateText), {});"
    end 
  end
end