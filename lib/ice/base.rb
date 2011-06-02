require 'v8'

class Object
  def to_ice
    nil
  end
end

[FalseClass, TrueClass, Numeric, String].each do |cls|
  cls.class_eval do
    def to_ice
      self
    end
  end
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

class Ice


 def self.convert_template(template_text, vars = {})

    V8::Context.new do |cxt|
      cxt.load "#{File.dirname(__FILE__)}/../parser.js"

      vars.each_pair do |key, value|
        cxt[key] = value.to_ice
      end

      jst = cxt['Jst']
      return @evaled = jst.evaluate(jst.compile(template_text), {})
    end
  end
  def self.compile_template(template_text)
    V8::Context.new do |cxt|
      cxt.load "#{File.dirname(__FILE__)}/../parser.js"
      jst = cxt['Jst']
      return jst.compile(template_text)
    end
  end

end

