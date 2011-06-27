require "ice/eco_template/base"

module Ice
  module EcoTemplate
    class Handler < ActionView::Template::Handler
      def self.call(template)
        <<-ECO
          
          template_source = <<-ECO_TEMPLATE
            #{template.source}
          ECO_TEMPLATE

          variable_names = controller.instance_variable_names
          variable_names -= %w[@template]
          if controller.respond_to?(:protected_instance_variables)
            variable_names -= controller.protected_instance_variables
          end
          
          variables = {}
          variable_names.each do |name|
            variables[name.sub(/^@/, "")] = controller.instance_variable_get(name)
          end
          
          Ice::EcoTemplate.convert_template(template_source, variables.merge(local_assigns))
        
        ECO
      end
    end
  end
end
