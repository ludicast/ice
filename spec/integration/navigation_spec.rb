require 'spec_helper'
require 'integration/template_renderer_group'

describe "Ice Format" do
  include Capybara::DSL

  context "with existing note" do

    before do
      @note = Note.create! :name => "Name #{rand(9999)}", :data => "Data #{rand(999)}"
    end

    it "is formatted in show" do
      visit note_path(@note.id, :format => :ice)
      headers['Content-Type'].should match(/ice/)
      retrieved_note = JSON::parser.new(page.source).parse
      retrieved_note["id"].should == @note.id
    end

    it "is formatted in index" do
      visit (notes_path :format => :ice)
      headers['Content-Type'].should match(/ice/)
      notes = JSON::parser.new(page.source).parse
      notes.last["id"].should == @note.id
    end

    it "skips fields" do
      visit note_path(@note.id, :format => :ice)
      puts page.source 
      page.source.should_not match(/Secret Data/)
      @note.to_json.should match(/Secret Data/)
    end

    protected

    def headers
      page.response_headers
    end

  end
end
