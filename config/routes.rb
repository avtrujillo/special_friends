Rails.application.routes.draw do

  root 'sessions#new'

  get    '/login',   to: 'sessions#new', as: 'login'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/help',             to: 'static_pages#help'
  #get '/home',             to: 'static_pages#home'

  get 'my_recipient',   to: 'friends#recipient',  as: 'recipient'
  get 'my_giver',       to: 'friends#giver',      as: 'giver'
  get 'my_generation',  to: 'friends#generation', as: 'generation'
  get 'user',           to: 'friends#user',       as: 'user'

  resources :generations, only: :show

  concern :has_gifts do
    resources :gifts do
      member do
        post 'received'
      end
    end
  end

  concern :has_wishes do
    resources :wishes
  end

  concerns :has_gifts, :has_wishes

  resources :friends, only: [:show, :index] do
    concerns :has_gifts, :has_wishes
    # '/friends/gifts/index' will list the gifts that a friend is receiving
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
