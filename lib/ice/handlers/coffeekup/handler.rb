require "ice/handlers/base"
require 'v8'

module Ice
  module Handlers
    module Coffeekup
      def self.convert_template(template_text, vars = {})
        Base.convert_template(template_text) do |context|
          coffeescript_file = "#{File.dirname(__FILE__)}/../../../../js/coffee-script.js"
          coffeekup_file = "#{File.dirname(__FILE__)}/../../../../js/coffeekup.js"

          context.eval(open(coffeescript_file).read)
          context.eval(open(coffeekup_file).read)

          coffeekup_helpers_file = "#{File.dirname(__FILE__)}/../../../../js/lib/coffeekup-path-helper.coffee"
          combo = open(coffeekup_helpers_file).read + "\n" + template_text.sub(/^(\s)*/, "")
          template = context["coffeekup"]["compile"].call(combo)
          template.call({context: vars.to_ice})
        end
      end

      def self.call(template)
        <<-COFFEEKUP
          template_source = <<-COFFEEKUP_TEMPLATE
            #{template.source}
          COFFEEKUP_TEMPLATE
          #{Base.variables}

          Ice::Handlers::Coffeekup.convert_template(template_source, variables.merge(local_assigns))
        COFFEEKUP
      end
    end
  end
end
