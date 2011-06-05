require 'ice'
require 'ice/cubeable'
require 'ice/cube_association'
require 'ice/base_cube'
require 'ice/base'
require 'ice/railtie'
require 'rails'


class EcoTemplateHandler

  class HtmlTemplateHandler < ActionView::Template::Handler

  include ActionView::Template::Handlers::Compilable

  self.default_format = :eco

  def compile(template)
        <<-ECO
          template_source = <<-ICE_TEMPLATE
            #{template.source}
          ICE_TEMPLATE
          variables = {}
          variable_names = controller.instance_variable_names
          variable_names -= %w[@template]
          if controller.respond_to?(:protected_instance_variables)
            variable_names -= controller.protected_instance_variables
          end
          variable_names.each do |name|
            variables[name.sub(/^@/, "")] = controller.instance_variable_get(name)
          end 
          Ice.convert_template(template_source, variables.merge(local_assigns))
        ECO

    
    end
  end
end


ActionView::Template.register_template_handler :eco, EcoTemplateHandler::HtmlTemplateHandler