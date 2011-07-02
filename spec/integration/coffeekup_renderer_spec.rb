require 'spec_helper'
require 'integration/template_renderer_group'

describe "Coffeekup Renderer" do
  include Capybara::DSL
  before(:all) do
    set_js_handler(:coffeekup)
  end

  it_should_behave_like "Template Renderer"
end
