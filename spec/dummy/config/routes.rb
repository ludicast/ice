Dummy::Application.routes.draw do
  resources :notes
  match ':controller/:action'
end
