Rails.application.routes.draw do

  root 'sessions#new'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'

  get '/help',                to: 'static_pages#help'

  #get '/give',                to: 'gifts#give' => /gift/new
  #get '/request_gift',        to: 'gifts#request_gift' => /wish/new
  # patch '/received/:id',      to: 'gifts#received'
  #get '/fulfill/:id',         to: 'gifts#fulfill' => wish/gift/new
  #patch '/fulfill/:id',       to: 'gifts#update_purchase' => wish/gift/update
  #post '/give',               to: 'gifts#create' => gift/create
  #post '/request_gift',       to: 'gifts#create' => wish/creeate
  #post './gifts',             to: 'gifts#create' => gift/create
  #get '/gift/:id',            to: 'gifts#show' => gift/show
  #get '/edit_wish/:id',       to: 'gifts#edit_wish' => wish/edit
  #patch '/edit_wish/:id',     to: 'gifts#update_wish' => wish/update
  #get '/edit_purchase/:id',   to: 'gifts#edit_purchase' => /gift/edit
  #patch '/edit_purchase/:id', to: 'gifts#update_purchase' => /gift/update
  #get   '/unwish/:id',        to: 'gifts#destroy_wish' => /wish/delete
  #delete '/unwish/:id',       to: 'gifts#destroy_wish' => /wish/destroy
  #delete '/ungift/:id',       to: 'gifts#destroy_purhase' => /gift/destroy

  resources :gifts do
    post 'received'
  end

  resources :friends, only: [:show, :index] do
    resources :gifts do
      post 'received'
    end
    resources :wishes do
      resources :gifts do
        post 'received'
      end
    end
  end

  resources :wishes do
    resources :gifts do
      post 'received'
    end
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
