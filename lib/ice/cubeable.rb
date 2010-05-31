module Ice
    module Cubeable
      def get_cube_class(class_obj)
        begin
          cube_string = class_obj.to_s + "Drop"
          cube_class = cube_string.constantize
          cube_class
        rescue
          get_cube_class class_obj.superclass
        end
      end

      def to_ice
        cube_class = get_cube_class self.class
        cube_class.new self
      end
    end
end
