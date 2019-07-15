Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      get 'users/me'
    end
  end
  namespace :api do
    namespace :v1 do
      post 'signup', to: 'signup#create'
      post 'signin', to: 'signin#create'
      post 'refresh', to: 'refresh#create'
      delete 'signin', to: 'signin#destroy'
      
      get 'me', controller: :users, action: :me

      resources :boards do
        get 'components' => :components
      end

      resources :uploads

      resources :components

      mount ActionCable.server => '/cable'
    end
  end
end
