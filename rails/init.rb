ActiveRecord::Base.send(:include, Ice::Cubeable)

require File.dirname(__FILE__) + "/../init"
require 'extras/ice_view'

if defined? ActionView::Template and ActionView::Template.respond_to? :register_template_handler
  ActionView::Template
else
  ActionView::Base
end.register_template_handler(:ice, IceView)
