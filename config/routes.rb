Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  #
  root 'motherclass#index'
  get "/person", to: "person#search"
  get '/person/:id/detail', to: 'person#get_details', as: 'person_detail'
  get '/person/:id/favorite', to: 'person#addfavorite', as: 'person_favorite'
  get "/courses", to: "courses#index"
  get "/projects", to: "projects#index"
  get "/theses", to: "theses#index"
end
