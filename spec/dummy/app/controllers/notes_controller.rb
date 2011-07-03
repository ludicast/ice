class NotesController < ApplicationController
  respond_to :html, :ice

  before_filter do
    perform_caching = false
   # puts "hola"
   # puts methods
   # puts methods.grep /view/
   # puts methods.grep /cache/
   # puts methods.grep /hand/
  end
  def show
    @note = Note.find(params[:id])
    respond_with(@note) do |format|
      format.ice { render :text => @note.to_ice.to_json }
    end
  end
  def index
    @notes = Note.all
    respond_with(@notes) do |format|
      format.ice { render :text => @notes.to_ice.to_json }
    end
  end
end
