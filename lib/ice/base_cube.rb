module Ice
  class BaseCube
    extend Ice::CubeAssociation 

    def self.revealing(* attributes)
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

    def initialize(source)
      @source = source
    end
  end
end