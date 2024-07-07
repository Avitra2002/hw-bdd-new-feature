Rottenpotatoes::Application.routes.draw do
  resources :movies do
    get 'similar', to: 'movies#similar', as: 'similar_movie'
  end

  root :to => redirect('/movies')
end
