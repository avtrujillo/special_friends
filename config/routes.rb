Rails.application.routes.draw do

  get 'wishes', to: 'wishes#unfulfilled', as: 'wishes', format: :html

  root 'sessions#new'
  get 'auth/facebook/callback', to: 'sessions#facebook'

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
  get 'unread_messages',          to: 'friend_messages#unread'

  resources :friend_messages, only: [:show, :index], format: :html

  resources :generations, only: [:show, :index], format: :html

  resources :gifts, format: :html

  get 'wishes/all',    to: 'wishes#all', as: 'all_wishes'



  # the index method for the wishes controller shows only unfulfilled wishes
  # the all method shows all wishes
  # the same applies for friends/:friend_id/wishes/[index/all]

  resources :friends, only: [:show, :index], format: :html do
    member do
      get 'generation',         to: "friends#generation"
      get 'giving_gifts',       to: 'friends#giving'
      get 'receiving_gifts',    to: 'friends#receiving'
      get 'wishes/unfulfilled', to: 'wishes#friend_unfulfilled'
      get 'wishes/all',         to: 'wishes#friend_all', as: 'all_wishes'
      get 'wishes',             to: 'wishes#friend_unfulfilled', as: 'wishes'
    end
    resources :gifts,   only: [:index, :new], format: :html
    # '/friends/gifts/index' will list the gifts that a friend is receiving
  end

  resources :wishes, except: [:index], format: :html do
    resources :gifts, only: [:index, :new], format: :html
  end

  get   'amazon/import',        to: 'amazon#import'
  post  'amazon/import',        to: 'amazon#create_list'
  get   'amazon/show_list/:id', to: 'amazon#show_list'

  get 'privacy_policy',         to: 'static_pages#privacy_policy'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
