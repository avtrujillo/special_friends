Rails.application.routes.draw do

  root 'sessions#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/help',                to: 'static_pages#help'
  get '/home',                to: 'static_pages#home'

  concern :has_gifts do
    resources :gifts do
      member do
        post 'recieved'
      end
    end
  end

  concern :has_wishes { resources :wishes { concerns :has_gifts } }

  concerns :has_gifts, :has_wishes

  resources :friends, only: [:show, :index] do
    concerns :has_gifts, :has_wishes
    # '/friends/gifts/index' will list the gifts that a friend is receiving
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
