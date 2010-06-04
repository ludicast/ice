module RoutesJs

  def get_routes

      response = rails_route_function

      ActionController::Routing::Routes.routes.collect do |route|
        path = route.segments.inject('') { |str,s| str << s.to_s }

        named_route = ActionController::Routing::Routes.
                        named_routes.routes.key(route).to_s

        if named_route != ''
          response << route_function("#{named_route}_path", path)
        end
      end

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

