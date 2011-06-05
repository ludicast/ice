require 'ice'
require 'ice/cubeable'
require 'ice/cube_association'
require 'ice/base_cube'
require 'ice/base'

require 'rails'
module RoutesJs

  def self.get_routes
      Ice::BaseCube.subclasses.map(&:name).inject("") do |string, name|
        name = name.sub(/Cube/, "").tableize
        string << get_route_functions(name)
      end


  end

  def self.get_route_functions(name)
<<-JAVASCRIPT

/* edit function for #{name}
 new function for #{name}
 index function for #{name}
*/
function #{name}_path() {
  return "/#{name}";
}

/*
show function for #{name}
*/
JAVASCRIPT
  end

end

class Ice
  require 'ice/railtie' if defined?(Rails)

  class HtmlTemplateHandler < ActionView::Template::Handler

  include ActionView::Template::Handlers::Compilable

  self.default_format = :ice

  def compile(template)
        <<-ICE
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
          route_functions = "<% " + RoutesJs::get_routes + " %>"
          path_helper_code = <<-ROUTE_JS
            #{File.read(File.dirname(__FILE__) + "/../js/lib/path-helper.js")}
          ROUTE_JS

          path_helper = "<% " + path_helper_code + " %>"

          source = path_helper + route_functions  + template_source
          Ice.convert_template(source, variables.merge(local_assigns))
        ICE
    end
  end
end


ActionView::Template.register_template_handler :ice, Ice::HtmlTemplateHandler