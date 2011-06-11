require "ice/eco_template/context"
require 'eco'
require 'v8'

module Ice
  module EcoTemplate
    def self.convert_template(template_text, vars = {})
      env = Context.new vars
      context = V8::Context.new

      context.eval(open "#{File.dirname(__FILE__)}/../../../js/lib/path-helper.js")
      IceJavascriptHelpers.each do |helper|
        context.eval(helper)
      end

      IceCoffeescriptHelpers.each do |helper|
        context.eval CoffeeScript.compile(helper, :bare => true)
      end
      context.eval(Eco::Source.combined_contents)

      template = context["eco"]["compile"].call(template_text)
      template.call(env)
    end
  end
end