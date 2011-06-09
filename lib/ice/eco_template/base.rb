require "ice/eco_template/context"
require 'eco'
require 'v8'

module Ice
  module EcoTemplate
    def self.convert_template(template_text, vars = {})
      env = Context.new vars
      context = V8::Context.new
      context.eval(Eco::Source.combined_contents)

      template = context["eco"]["compile"].call(template_text)
      # Render the template
      template.call(env)
    end
  end
end