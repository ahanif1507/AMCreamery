Rails.application.routes.draw do
    
  get 'jobs/new'
  get 'jobs/edit'
  get 'jobs/index'
  get 'jobs/show'
  get 'shift_jobs/new'
  get 'shift_jobs/edit'
  get 'shift_jobs/index'
  get 'shift_jobs/show'
  get 'shifts/new'
  get 'shifts/edit'
  get 'shifts/index'
  get 'shifts/show'
  get 'pay_grade_rates/new'
  get 'pay_grade_rates/edit'
  get 'pay_grade_rates/index'
  get 'pay_grade_rates/show'
  get 'pay_grades/new'
  get 'pay_grades/edit'
  get 'pay_grades/index'
  get 'pay_grades/show'
 root 'home#index'
    
  get 'stores/index'
  get 'stores/new'
  get 'stores/show'
  get 'stores/edit'
  get 'assignments/index'
  get 'assignments/new'
  get 'assignments/terminate'
  get 'employees/index'
  get 'employees/new'
  get 'employees/show'
  get 'employees/edit'
  get 'home/index'
  get 'home/about'
  get 'home/contact'
  get 'home/privacy'
  
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
  
  get 'assignments/terminate'
  
  get '/employees/:id/detail', to: 'employees#detail', as: :detail
  
  resources :employees
  resources :assignments
  resources :stores

end
