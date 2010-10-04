module Ice
  class BaseCube
    extend Ice::CubeAssociation 

    def self.revealing(* attributes) 
      unless @attribute_names
        @attribute_names = []
      end
      @attribute_names.concat(attributes)

      attributes.each do |attr|
        define_method attr.to_sym do
          @source.send(attr).to_ice
        end
      end
    end

    attr_reader :source

    def to_ice
      self
    end

    def to_hash
      if @attribute_names
        hash = {:id => @source.id}
        @attribute_names && @attribute_names.each do |name|
          hash[name] = @source.send(name)
        end
        hash
      else
        @hash = @source.serializable_hash
      end
    end

    def id
      @source.id
    end

    def initialize(source)
      @source = source
      unless @attribute_names
        to_hash.each_key do |key|
          unless self.respond_to? key.to_sym
            self.class.send :define_method, key.to_sym do
              @source.send(key.to_sym)
            end
          end
        end
      end
    end

  end
end