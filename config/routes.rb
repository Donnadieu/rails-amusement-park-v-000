Rails.application.routes.draw do

  get 'attractions/index'

  resources :users
  resources :attractions do
    resources :rides
  end


  root 'welcome#home'

  get '/signin', :to => 'sessions#new'
  post '/signin', :to => 'sessions#create'
  get '/logout', :to => 'sessions#destroy'
end
