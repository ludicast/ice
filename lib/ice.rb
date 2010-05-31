require 'rubygems'
require 'v8'

class Object
  def to_cube
    nil
  end
end

[FalseClass, TrueClass, Numeric, String].each do |class_name|
  eval "class #{class_name}
    def to_cube
      self
    end
  end"
end

class Array
  def to_cube
    map &:to_cube
  end
end

class Hash
  def to_cube
    res = {}
    each_pair do |key,value|
      res[key] = value.to_cube
    end
    res
  end
end



module Ice
  def self.convert_template(template_text, vars = {})

    V8::Context.new do |cxt|
      cxt.load "#{File.dirname(__FILE__)}/parser.js"

      vars.each_pair do |key, value|
        cxt[key] = value.to_cube
      end

      cxt['____templateText'] = template_text

      @evaled = cxt.eval "Jst.evaluate(Jst.compile(____templateText), {});"

    end
    @evaled
  end
end

