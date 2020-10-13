Rottenpotatoes::Application.routes.draw do
  resources :movies
  # map '/' to be a redirect to '/movies'
  root :to => redirect('/movies')
  get "/same_director/:title", to: "movies#samedirector", as: "search_directors"
end
