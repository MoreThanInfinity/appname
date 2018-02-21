Rails.application.routes.draw do



  root "home#index"
  #post 'follows/create'
  #post 'follows/destroy'
  #get 'profiles/edit'=>'profiles#edit'
  #patch 'profiles/create'=>'prfiles#create'
  resources :comments do
    member do
      put 'like' => 'comments#vote'
    end
  end

  resources :posts do
    member do
      put 'like' => 'posts#vote'
    end
  end

  devise_for :users

  resources :users do
    member do
      put 'follow' => 'users#subscribe'
    end
  end

  resources :chats
  resources :com_chats, controller: 'chats', chat_kind: 'ComChat'
  match 'chats/:id', to: ChatsController.action(:show), via: [:get, :post]
  resources :pers_chats, controller: 'chats', chat_kind: 'PersChat'

  resources :messages

  get 'home/event'
  get 'home/index'

  mount ActionCable.server => '/cable'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
