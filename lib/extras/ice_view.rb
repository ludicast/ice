# IceView is a action view extension class. You can register it with rails
# and use ice as an template system for .ice files
#
# Example
#
#   ActionView::Base::register_template_handler :ice, IceView

module RoutesJs

  def get_routes

      response = rails_route_function

      Rails.application.routes.routes.collect do |route|

        puts route.class.to_s
        puts route.path



        puts route.inspect

        path = route.path
        puts "%%%"
        puts route.conditions.inspect
        puts route.requirements

        named_route = Rails.application.routes.
                        named_routes.routes.key(route).to_s

        if named_route != ''
          puts named_route +  "   kkyy   " + route.path

          if path.match /(.*)\(\.\:format\)$/
            path = $1
          end

          response << route_function("#{named_route}_path", path)
        end
      end
     # puts response
      response
  end

private

  def rails_route_function
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

  def route_function name, path
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

class IceView
  include RoutesJs
  include ActionView::Template::Handlers::Compilable
  PROTECTED_ASSIGNS = %w( template_root response _session template_class action_name request_origin session template
                          _response url _request _cookies variables_added _flash params _headers request cookies
                          ignore_missing_templates flash _params logger before_filter_chain_aborted headers )
  PROTECTED_INSTANCE_VARIABLES = %w( @_request @controller @_first_render @_memoized__pick_template @view_paths
                                     @helpers @assigns_added @template @_render_stack @template_format @assigns )

 # attr_accessor :controller

#  def self.call(template)
#    "IceView.new(self).render(#{template})"
#  end

  def initialize(view = nil)
    @view = view
  end

  def compile(template)

    "IceView.new(self).render('#{template.inspect}' )"
  end

  def render(template, local_assigns = {})

    @view.controller.headers["Content-Type"] ||= 'text/html; charset=utf-8'
    source = open(Rails.root + template).read

    assigns = @view.assigns.reject{ |k,v| PROTECTED_ASSIGNS.include?(k) }
    if content_for_layout = @view.instance_variable_get("@content_for_layout")
      assigns['content_for_layout'] = content_for_layout
    end
    assigns.merge!(local_assigns.stringify_keys)
    route_functions = "<% "  + get_routes + " %>\n"

    path_helper_code = File.read(File.dirname(__FILE__) + "/../../ice_js/lib/path_helper.js")
    path_helper = "<% " + path_helper_code + " %>\n"


    source = route_functions + path_helper + source
   # puts source

    Ice.convert_template(source, assigns)
=begin


    puts "hhhhhhhooooootttt"
    # Rails 2.2 Template has source, but not locals
    if template.respond_to?(:source) && !template.respond_to?(:locals)
      assigns = (@view.instance_variables - PROTECTED_INSTANCE_VARIABLES).inject({}) do |hash, ivar|
                  hash[ivar[1..-1]] = @view.instance_variable_get(ivar)
                  hash
                end
    else
      assigns = @view.assigns.reject{ |k,v| PROTECTED_ASSIGNS.include?(k) }
    end

    source = template.respond_to?(:source) ? template.source : template
    local_assigns = (template.respond_to?(:locals) ? template.locals : local_assigns) || {}

    if content_for_layout = @view.instance_variable_get("@content_for_layout")
      assigns['content_for_layout'] = content_for_layout
    end
    assigns.merge!(local_assigns.stringify_keys)

    route_functions = "<% "  + get_routes + " %>"

    path_helper_code = File.read(File.dirname(__FILE__) + "/../../ice_js/lib/path_helper.js")
    path_helper = "<% " + path_helper_code + " %>"
    source = route_functions + path_helper + source

    puts "ooooootttt"
    Ice.convert_template(source, assigns)
    #ice = Ice::Template.parse(source)
    #ice.render(assigns, :filters => [@view.controller.master_helper_module], :registers => {:action_view => @view, :controller => @view.controller})

=end


  end

  def compilable?
    false
  end

end