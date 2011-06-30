require "ice/handlers/base"
require 'eco'
require 'v8'

module Ice
  module Handlers
    module Eco
      def self.convert_template(template_text, vars = {})
        Base.convert_template(template_text) do |context|
          context.eval(::Eco::Source.combined_contents)
          template = context["eco"]["compile"].call(template_text)
          template.call(vars.to_ice)
        end
      end

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

      def self.call(template)
        <<-ECO
          template_source = <<-ECO_TEMPLATE
            #{template.source}
          ECO_TEMPLATE

          #{variables}

          Ice::Handlers::Eco.convert_template(template_source, variables.merge(local_assigns))
        ECO
      end
    end
  end
end
