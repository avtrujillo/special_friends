Rails.application.routes.draw do

  root 'sessions#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/help',                to: 'static_pages#help'

  get '/give',                to: 'gifts#give'
  get '/request_gift',        to: 'gifts#request_gift'
  patch '/recieved/:id',      to: 'gifts#recieved'
  get '/fulfill/:id',         to: 'gifts#fulfill'
  patch '/fulfill/:id',       to: 'gifts#update_purchase'
  post '/give',               to: 'gifts#create'
  post '/request_gift',       to: 'gifts#create'
  post './gifts',             to: 'gifts#create'
  get '/gift/:id',            to: 'gifts#show'
  get '/edit_wish/:id',       to: 'gifts#edit_wish'
  patch '/edit_wish/:id',     to: 'gifts#update_wish'
  get '/edit_purchase/:id',   to: 'gifts#edit_purchase'
  patch '/edit_purchase/:id', to: 'gifts#update_purchase'
  delete '/unwish/:id',       to: 'gifts#destroy_wish'
  delete '/ungift/:id',       to: 'gifts#destroy_purhase'



  resources :friends, only: [:show, :index]
  resources :gifts,   only: [:show, :index]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
