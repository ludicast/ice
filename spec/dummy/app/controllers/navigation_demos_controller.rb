class NavigationDemosController < ApplicationController
  def sample_nav_bar
    
  end
  def override_nav_bar

  end
  def routed_nav_bar
    @note = Note.last || Note.create!(:name => "yoo #{rand(100)}", :data => "wee #{rand(200)}")
  end

end