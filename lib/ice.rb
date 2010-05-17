require 'rubygems'
require 'v8'

module Ice
  def self.convert_template(template_text, vars = {})
    V8::Context::open do |cxt|
      cxt.load "#{File.dirname(__FILE__)}/parser.js"
      vars.each_pair do |key, value|
        cxt[key] = value
      end

      cxt['____templateText'] = template_text
      cxt.eval "Jst.evaluate(Jst.compile(____templateText), {});"
    end 
  end

  def self.template_parser


  end


end