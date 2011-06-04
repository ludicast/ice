require 'ice'
require 'ice/cubeable'
require 'ice/cube_association'
require 'ice/base_cube'
require 'ice/base'

require 'rails'
module RoutesJs

  def self.get_routes

      response = rails_route_function

      Rails.application.routes.routes.collect do |route|
        path = route.segment_keys.inject('') { |str,s| str << s.to_s }
        named_route =Rails.application.routes.
                        named_routes.routes.key(route).to_s

        if named_route != ''
          response << route_function("#{named_route}_path", path)
        end
      end

      response
  end

private

  def self.rails_route_function
<<EOF
function rails_route(path, var_pairs) {
var pair_index = 0,
path_copy = path;
for(; pair_index < var_pairs.length; pair_index++) {
path_copy = path_copy.replace(
':' + var_pairs[pair_index][0],
var_pairs[pair_index][1]
);
}
return(
path_copy
.replace(/[(][.]:.+[)][?]/g, '')
.replace(/[(]|[)][?]/g, '')
);
}
EOF
  end

  def self.route_function name, path
<<EOF
function #{name}(variables) {
var var_pairs = [];
for(var key in variables) {
var_pairs.push([key, variables[key]]);
}
return(rails_route('#{path}', var_pairs));
}
EOF
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