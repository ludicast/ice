require 'active_model/serialization'
require 'action_view'

module Ice
  class Railtie < Rails::Railtie
    initializer "ice.configure_rails_initialization" do

    end  
  end
end

ActiveModel::Serialization.send(:include, Ice::Cubeable)

require 'extras/ice_view'

if defined? ActionView::Template and ActionView::Template.respond_to? :register_template_handler
  ActionView::Template
else
  ActionView::Base
end.register_template_handler(:ice, IceView)
