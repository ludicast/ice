require 'active_model/serialization'
require 'action_view'

class Ice
  class Railtie < Rails::Railtie
    initializer "ice.configure_rails_initialization" do
      
    end  
  end

end

ActiveModel::Serialization.send(:include, Ice::Cubeable)