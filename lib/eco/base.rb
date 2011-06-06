require "eco/context"

module Eco
  def self.convert_template(template_text, vars = {})
    env = Eco::Context.new vars
    require 'eco'
    Eco.render template_text, env
  end
end

