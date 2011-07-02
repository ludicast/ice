require "ice/handlers/base"
require 'eco'
require 'v8'

module Ice
  module Handlers
    module Eco
      def self.convert_template(template_text, vars = {})
        Base.convert_template(template_text) do |context|
          helpers = "#{File.dirname(__FILE__)}/../../../../js/lib/eco-path-helper.js"

          context.eval(open(helpers).read)
          context.eval(::Eco::Source.combined_contents)
          template = context["eco"]["compile"].call(template_text)
          template.call(vars.to_ice)
        end
      end

      def self.call(template)
        <<-ECO
          template_source = <<-ECO_TEMPLATE
            #{template.source}
          ECO_TEMPLATE

          #{Base.variables}

          Ice::Handlers::Eco.convert_template(template_source, variables.merge(local_assigns))
        ECO
      end
    end
  end
end
