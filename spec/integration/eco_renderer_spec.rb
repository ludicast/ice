require 'spec_helper'
require 'integration/template_renderer_group'

describe "Eco Renderer" do
  include Capybara::DSL
  before(:all) do
    set_js_handler(:eco)
  end

  it_should_behave_like "Template Renderer"

  it "allows class-wide javascript overrides" do
    javascript = <<-JAVASCRIPT
  NavBarConfig = {
    navPrefix: "<div>",
    navPostFix: "</div>",
    linkPrefix: "<span>",
    linkPostFix: "</span>"
  };
    JAVASCRIPT

    mock_out_enumerable_each IceJavascriptHelpers, javascript
    visit "/navigation_demos/sample_nav_bar"
    page.should have_xpath('//div/span/a')
  end

  it "allows class-wide coffeescript overrides" do
    coffeescript = <<-COFFEESCRIPT
  NavBarConfig =
    navPrefix: "<div>",
    navPostFix: "</div>",
    linkPrefix: "<span>",
    linkPostFix: "</span>"
    COFFEESCRIPT

    mock_out_enumerable_each IceCoffeescriptHelpers, coffeescript
    visit "/navigation_demos/sample_nav_bar"
    page.should have_xpath('//div/span/a')
  end  
end
