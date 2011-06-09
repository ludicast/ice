module Ice
  module Cubeable
    def get_cube_class(class_obj)
      begin
        cube_string = class_obj.to_s + "Cube"
        cube_string.constantize
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
