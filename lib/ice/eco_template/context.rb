module Ice
  module EcoTemplate
    class Context < Hash

      def initialize(hash)
        add_routes
        hash.each_pair do |key, value|
          self[key] = value.to_ice
        end
      end

      private

      def add_routes
        Ice::BaseCube.subclasses.map(&:name).each do |cube_model_name|
          model_name = cube_model_name.sub(/Cube/, "")
          name = model_name[0].downcase + model_name[1..-1]

          self["edit" + model_name + "Path"]= lambda do |object|
            "/#{name.tableize}/#{object.id}/edit"
          end

          self["new" + model_name + "Path"]= lambda do
            "/#{name.tableize}/new"
          end

          self[name + "Path"]= lambda do |object|
            "/#{name.tableize}/#{object.id}"
          end

          self[name.pluralize + "Path"]= lambda do
            "/#{name.tableize}"
          end

        end
      end

    end
  end
end