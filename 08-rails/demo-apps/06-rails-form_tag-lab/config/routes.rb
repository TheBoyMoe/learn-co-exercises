Rails.application.routes.draw do

  # get 'students', to: 'students#index' # students_path
  # get '/student/:id', to: 'students#show', as: 'student' # student_path(:id)
  # get '/students/new', to: 'students#new', as: 'new_student' # new_student_path
  # post '/students', to: 'students#create'

  # alternative
  resources :students, only: [:index, :show, :new, :create]

# rails routes
=begin
       Prefix Verb URI Pattern             Controller#Action
     students GET  /students(.:format)     students#index
              POST /students(.:format)     students#create
  new_student GET  /students/new(.:format) students#new
      student GET  /students/:id(.:format) students#show
=end

end
