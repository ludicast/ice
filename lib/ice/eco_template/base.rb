require "ice/eco_template/generated_helpers"
require 'eco'
require 'v8'

module Ice
  module EcoTemplate
    def self.__convert_template(template_text)
      V8::C::Locker() do
        context = V8::Context.new
        context.eval(open "#{File.dirname(__FILE__)}/../../../js/lib/path-helper.js")

        IceJavascriptHelpers.each do |helper|
          context.eval(helper)
        end
        IceCoffeescriptHelpers.each do |helper|
          context.eval CoffeeScript.compile(helper, :bare => true)
        end

        context.eval CoffeeScript.compile(GeneratedHelpers.get_routes, :bare => true)
        yield context

      end
    end

    def self.convert_template(template_text, vars = {})
      __convert_template(template_text) do |context|
        context.eval(Eco::Source.combined_contents)
        template = context["eco"]["compile"].call(template_text)
        template.call(vars.to_ice)
      end
    end
  end
end
