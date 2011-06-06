class NavigationDemosController < ApplicationController
  def sample_nav_bar
    
  end
  def override_nav_bar

  end
  def routed_nav_bar
    @note = Note.last
  end

end