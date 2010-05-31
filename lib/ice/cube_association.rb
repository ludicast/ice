module Ice
  module CubeAssociation
    def belongs_to(*args)
      args.each do |sym|
        belongs_to = %{
        def #{sym}
          @source.#{sym}
        end
        def #{sym}_id
          @source.#{sym}_id
        end
        }
        class_eval belongs_to
      end
    end

    def has_many(*args)
      args.each do |sym|
        has_many = %{
        def #{sym}
          @source.#{sym}
        end
        def has_#{sym}
          ! @source.#{sym}.empty?
        end
        def num_#{sym}
          @source.#{sym}.count
        end
        def #{sym.to_s.singularize}_ids
           @source.#{sym.to_s.singularize}_ids
        end
        }
        class_eval has_many
      end

    end
  end
end