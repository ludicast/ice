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
      hash = {:id => @source.id}
      @attribute_names && @attribute_names.each do |name|
        hash[name] = @source.send(name)
      end
      hash
    end

    def id
      @source.id
    end

    def initialize(source)
      @source = source
    end
  end
end