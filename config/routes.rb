Rails.application.routes.draw do
  root 'mother_class#index', as: 'root'

  # Person routes
  get "/person", to: "person#search"
  get '/person/:id/detail', to: 'person#get_details', as: 'person_detail'
  post '/person/:id/favorite', to: 'favorites#create', as: 'person_favorite'

  # Courses routes
  get "/courses", to: "courses#index"
  get "/courses/:title/detail", to: "courses#get_details", as: "course_detail"
  post '/courses/favorite', to: 'favorites#create', as: 'course_favorite'

  # Projects routes
  get "/projects", to: "projects#index"
  get '/projects/:id/detail', to: 'projects#get_details', as: 'projects_detail'
  post '/projects/:id/favorite', to: 'favorites#create', as: 'projects_favorite'

  # Theses routes
  get "/theses", to: "theses#index"
  get '/theses/:id/detail', to: 'theses#get_details', as: 'theses_detail'
  post '/theses/favorite', to: 'favorites#create', as: 'theses_favorite'

  get '/login', to: 'sessions#new', as: 'login'
  post '/login', to: 'sessions#create', as: 'login_create'
  get '/register', to: 'users#new', as: 'register'
  post '/register', to: 'users#create', as: 'register_create'
  get '/logout', to: 'sessions#destroy', as: 'logout'

  # Favorites routes
  resources :favorites, only: [:index, :create, :destroy, :edit, :update]

  # Person Reports routes
  resources :person_reports, only: [:show]
end