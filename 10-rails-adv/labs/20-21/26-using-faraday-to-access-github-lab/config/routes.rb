Rails.application.routes.draw do
  get '/search', to: 'repositories#search'
  post '/search', to: 'repositories#github_search'
  root 'repositories#search'
end
