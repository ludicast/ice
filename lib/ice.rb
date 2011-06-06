require 'ice'
require 'ice/cubeable'
require 'ice/cube_association'
require 'ice/base_cube'

require 'ice/railtie'
require 'ice/cube_helpers'
require 'rails'

require 'eco/base'

NavBarConfig = {}

module Eco

  class TemplateHandler < ActionView::Template::Handler

    include ActionView::Template::Handlers::Compilable

    self.default_format = :eco

    def compile(template)
        <<-ECO
          template_source = <<-ECO_TEMPLATE
            #{template.source}
          ECO_TEMPLATE
          variables = {}
          variable_names = controller.instance_variable_names
          variable_names -= %w[@template]
          if controller.respond_to?(:protected_instance_variables)
            variable_names -= controller.protected_instance_variables
          end
          variable_names.each do |name|
            variables[name.sub(/^@/, "")] = controller.instance_variable_get(name)
          end
          Eco.convert_template(template_source, variables.merge(local_assigns))
        ECO

    end
  end
end


ActionView::Template.register_template_handler :eco, Eco::TemplateHandler