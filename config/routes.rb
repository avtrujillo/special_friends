Rails.application.routes.draw do

  resources :friend_messages
  root 'sessions#new'

  get 'error/:error_id', to: 'htmlerrors#error_status_page'

  get    '/login',   to: 'sessions#new', as: 'login'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/help',             to: 'static_pages#help'
  #get '/home',             to: 'static_pages#home'

  get 'my_recipient',       to: 'friends#recipient',  as: 'recipient'
  get 'my_generation',      to: 'generations#my_gen'
  get 'user',               to: 'friends#user',       as: 'user'

  get 'gifts/giver/:giver_id/recipient/:recipient_id', to: 'gifts#from_to', as: 'from_to'

  get 'friend_wishes_ajax/:id', to: 'wishes#friend_wishes_ajax'

  get 'new_message_to_recipient', to: 'friend_messages#new_message_to_recipient'
  get 'new_message_to_giver',     to: 'friend_messages#new_message_to_giver'
  get 'messages_as_giver',        to: 'friend_messages#messages_as_giver'
  get 'messages_as_recipient',    to: 'friend_messages#messages_as_recipient'
  get 'unread_message'            to: 'friend_messages#unread'

  resources :friend_messages, only: [:show, :index]

  resources :generations, only: [:show, :index]

  resources :gifts

  resources :wishes

  resources :friends, only: [:show, :index] do
    member do
      get 'generation',      to: "friends#generation"
      get 'giving_gifts',    to: 'friends#giving'
      get 'receiving_gifts', to: 'friends#receiving'
    end
    resources :gifts,   only: [:show, :index, :new]
    resources :wishes,  only: [:show, :index]
    # '/friends/gifts/index' will list the gifts that a friend is receiving
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
