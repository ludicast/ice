class NotesController < ApplicationController

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
  end
  def index
    @notes = Note.all
  end
end
