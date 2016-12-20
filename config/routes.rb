Rails.application.routes.draw do

  root login_path

  get '/help',              to: 'static_pages#help'

  get '/login',             to: 'sessions#new'
  post '/login',             to: 'sessions#create'
  delete '/login'            to: 'sessions#destroy'

  get '/friend/:id'         to: 'friends#show'
  get '/friends'             to: 'friends#index'

  get '/gifts'              to: 'gifts#index'
  get '/gift/:id'           to: 'gifts#show'
  get '/give'               to: 'gifts#give'
  get '/request'            to: 'gifts#request'
  patch '/recieved/:id'     to: 'gifts#recieved'
  get '/fulfill/:id'        to: 'gifts#fulfill'
  patch '/fulfill/:id'      to: 'gifts#update_purchase'
  post '/give'              to: 'gifts#create'
  post '/request'           to: 'gifts#create'
  get '/show/gift/:id'      to: 'gifts#show'
  get '/edit_wish/:id'      to: 'gifts#edit_wish'
  put '/edit_wish/:id'      to: 'gifts#update_wish'
  get '/edit_purchase/:id'  to: 'gifts#edit_purchase'
  patch '/edit_purchase/:id'to: 'gifts#update_purchase'
  delete '/unwish/:id'      to: 'gifts#destroy_wish'
  delete '/ungift/:id'      to: 'gifts#destroy_purhase'



  resources :friends
  resources :gifts,   only: [:show, :index]

  root 'application#hello'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
