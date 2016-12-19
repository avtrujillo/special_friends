Rails.application.routes.draw do

  root 'static_pages#home'
  get '/help',        to: 'static_pages#help'
  get '/login',       to: 'sessions#new'
  post 'login',       to: 'sessions#create'
  delete 'login'      to: 'sessions#destroy'
  get '/gifts'        to: 'gifts#index'
  get 'give'          to: 'gifts#give'
  get '/request'      to: 'gifts#request'
  post '/give'        to: 'gifts#create'
  post '/request'     to: 'gifts#create'
  get 'show/gift/:id' to: 'gifts#show'


  resources :friends
  resources :gifts,   only: [:show, :show_gift, :edit_wish, :edit_purchase]

  root 'application#hello'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
