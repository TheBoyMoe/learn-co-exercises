Rails.application.routes.draw do
  resources :students, only: :index

  get '/student/:id', to: 'students#show', as: 'student'
  get '/students/new', to: 'students#new', as: 'new_student'
  post '/students', to: 'students#create'
end
