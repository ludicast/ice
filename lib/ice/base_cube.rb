module Ice
  class BaseCube
    extend Ice::CubeAssociation 
    attr_reader :source

    def to_ice
      self
    end

    def id
      @source.id
    end

    def self.attribute_names
      @@attribute_names ||= []
    end

    def self.revealing(* attributes)
      attribute_names.concat(attributes)

      attributes.each do |attr|
        define_method attr.to_sym do
          @source.send(attr).to_ice
        end
      end
    end


    def to_hash
      if self.class.attribute_names.count > 0
        hash = {}
        ([:id, :created_at, :updated_at] +
            self.class.attribute_names).each do |method|
          if @source.respond_to? method
            hash[method] = source.send(method)
          end
        end
        hash
      else
        @hash ||= @source.serializable_hash.to_ice
      end
    end

    def to_json
      to_hash.to_json
    end


    def initialize(source)
      @source = source
      
      unless self.class.attribute_names.count > 0
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