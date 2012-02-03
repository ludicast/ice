require 'active_model/serialization'
require 'action_view'
require 'active_record/base'

module Ice
  class Railtie < Rails::Railtie
    initializer "ice.configure_rails_initialization" do
      
    end  
  end

end

ActiveModel::Serialization.send(:include, Ice::Cubeable)

ActiveRecord::Base.send(:include, Ice::Cubeable)
