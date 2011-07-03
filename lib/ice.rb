require 'ice'
require 'ice/cubeable'
require 'ice/cube_association'
require 'ice/base_cube'

require 'ice/railtie'
require 'ice/cube_helpers'
require 'rails'

require 'ice/handlers/eco/handler'
require 'ice/handlers/coffeekup/handler'

IceJavascriptHelpers = []
IceCoffeescriptHelpers = []

ActionView::Template.register_template_handler :coffeekup, Ice::Handlers::Coffeekup
ActionView::Template.register_template_handler :eco, Ice::Handlers::Eco

require "action_controller"
Mime::Type.register "text/ice", :ice

ActionController::Renderers.add :ice do |object, options|
  puts "oootototOOOOOOOOOO"
  puts "rendering with #{object}"
  puts "rendering to #{object.to_ice.to_json}"
  self.send_data object.to_ice.to_json, :type => :ice
end