require "ice/eco_template/context"
require 'eco'
require 'v8'

module Ice
  module EcoTemplate

    def self.get_routes
      coffeescript = ""
      Ice::BaseCube.subclasses.map(&:name).each do |cube_model_name|
        model_name = cube_model_name.sub(/Cube/, "")
        name = model_name[0].downcase + model_name[1..-1]

        coffeescript << <<-COFFEESCRIPT

edit#{model_name}Path = (object)->
  "/#{name.tableize}/" + object.id + "/edit"

new#{model_name}Path = ()->
  "/#{name.tableize}/new"

#{name}Path = (object)->
  "/#{name.tableize}/" + object.id

#{name.pluralize}Path = ()->
  "/#{name.tableize}"

        COFFEESCRIPT
      end
      coffeescript
    end
    def self.convert_template(template_text, vars = {})
      env = Context.new vars
      context = V8::Context.new

      context.eval(open "#{File.dirname(__FILE__)}/../../../js/lib/path-helper.js")
      IceJavascriptHelpers.each do |helper|
        context.eval(helper)
      end
      IceCoffeescriptHelpers.each do |helper|
        context.eval CoffeeScript.compile(helper, :bare => true)
      end
      context.eval CoffeeScript.compile(get_routes, :bare => true)
      context.eval(Eco::Source.combined_contents)

      template = context["eco"]["compile"].call(template_text)
      template.call(env)
    end
  end
end