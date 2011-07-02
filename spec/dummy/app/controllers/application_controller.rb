class ApplicationController < ActionController::Base
  protect_from_forgery

   def self.parent_prefixes
        @parent_prefixes ||= begin
          parent_controller = superclass
          prefixes = []

          until parent_controller.abstract?
            prefixes << parent_controller.controller_path
            parent_controller = parent_controller.superclass
          end

          prefixes
        end
      end

    def _prefixes
      @_prefixes ||= begin
        parent_prefixes = self.class.parent_prefixes
        parent_prefixes.dup.unshift(controller_path)
      end
    end

  def lookup_contextoos
    puts ">>>>>>>LOOKUp<<<<<< #{self.class._view_paths}  ::: #{@_lookup_context}"
     # @_lookup_context ||=
        ActionView::LookupContext.new(self.class._view_paths, {})
  end
end
