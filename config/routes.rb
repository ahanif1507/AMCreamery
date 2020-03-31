Rails.application.routes.draw do
    
  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy

  get 'stores/new'
  get 'stores/create'
  get 'home/new'
  get 'home/create'
  get 'employees/new'
  get 'employees/create'
  get 'assignments/new'
  get 'assignments/create'
  get 'assignment/new'
  get 'assignment/create'
  # Your routes go here
  
  resources :employees
  resources :assignments
  resources :stores

end
