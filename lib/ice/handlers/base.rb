require "ice/generated_helpers"

module Ice
  module Handlers
    module Base
      def self.variables
        <<-VARIABLES
          variable_names = controller.instance_variable_names
          variable_names -= %w[@template]
          if controller.respond_to?(:protected_instance_variables)
            variable_names -= controller.protected_instance_variables
          end

          variables = {}
          variable_names.each do |name|
            variables[name.sub(/^@/, "")] = controller.instance_variable_get(name)
          end
        VARIABLES
      end

      def self.convert_template(template_text)
        V8::C::Locker() do
          context = V8::Context.new

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