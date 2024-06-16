Rails.application.routes.draw do
  root 'mother_class#index', as: 'root'

  # Person routes
  get "/person", to: "person#search"
  get '/person/:id/detail', to: 'person#get_details', as: 'person_detail'
  post '/person/:id/favorite', to: 'favorites#create', as: 'person_favorite'
  get '/person/:id/report', to: 'person#full_report', as: 'full_report'
  get '/person/:id/courses', to: 'person#courses', as: 'person_courses'
  get '/person/:id/theses', to: 'person#theses', as: 'person_theses'
  get '/person/:id/projects', to: 'person#projects', as: 'person_projects'

  # Courses routes
  get "/courses", to: "courses#index"
  get "/courses/:id/detail", to: "courses#get_details", as: "course_detail"
  post '/courses/:id/favorite', to: 'favorites#create', as: 'course_favorite'

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

  get '/report', to: 'reports#index', as: 'report_index'
  get '/report/:type', to: 'reports#show', as: 'report_show'


  # Favorites routes
  resources :favorites, only: [:index, :create, :destroy, :edit, :update]

  # Person Reports routes
  resources :person_reports, only: [:show]
end