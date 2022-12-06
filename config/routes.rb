Rails.application.routes.draw do
  root 'pages#home'

  get 'call', to: 'call#user', as: 'call_user'
  post 'call', to: 'call#create'

  resources :rooms do
    resources :messages
    collection do
      post :search
    end
  end
  # leave_room_path(room)
  get 'rooms/leave/:id', to: 'rooms#leave', as: 'leave_room'
  # join_room_path(room)
  get 'rooms/join/:id', to: 'rooms#join', as: 'join_room'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get 'user/:id', to: 'users#show', as: 'user'

  authenticated :user, ->(user) { user.admin? } do
    get 'admin', to: 'admin#index'
    get 'admin/rooms'
    get 'admin/messages'
    get 'admin/users'
    get 'admin/message/:id', to: 'admin#show_message', as: 'admin_message'
  end

end
