require "ice/generated_helpers"

module Ice
  module Handlers
    module Base
      def self.convert_template(template_text)
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
    end
  end
end