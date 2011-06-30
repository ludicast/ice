module Ice
  module GeneratedHelpers
      def self.get_routes
        coffeescript = ""
        Ice::BaseCube.subclasses.map(&:name).each do |cube_model_name|
          model_name = cube_model_name.sub(/Cube/, "")
          name = model_name[0].downcase + model_name[1..-1]

          coffeescript << <<-COFFEESCRIPT

  edit#{model_name}Path = (object)->
    "/#{name.tableize}/" + object.id + "/edit"

  new#{model_name}Path = ()->
    "/#{name.tableize}/new"

  #{name}Path = (object)->
    "/#{name.tableize}/" + object.id

  #{name.pluralize}Path = ()->
    "/#{name.tableize}"

          COFFEESCRIPT
        end
        coffeescript
      end
    
  end
end