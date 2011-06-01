require 'spec_helper'

describe "Navigation" do
  include Capybara
  
  it "should show the show page" do
    @note = Note.create! :name => "note name", :data => "data goes here"
    visit note_path(@note)
    page.should have_content(@note.name)
    page.should have_content(@note.data)
  end
end
