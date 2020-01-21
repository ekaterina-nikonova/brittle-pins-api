Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post "graphql", to: "graphql#execute"

      get 'me', to: 'users#me'
      post 'signup', to: 'signup#create'
      post 'signup-guest', to: 'signup#create_guest'
      post 'signin', to: 'signin#create'
      post 'refresh', to: 'refresh#create'
      delete 'signin', to: 'signin#destroy'

      resources :projects

      resources :boards do
        get 'components' => :components
      end

      post 'uploads', to: 'uploads#create'
      delete 'uploads', to: 'uploads#destroy'

      resources :components

      namespace :admin do
        resources :invitations, only: %i[index create destroy]
        delete 'invitation-reject/:id', to: 'invitations#destroy_with_rejection'
        patch 'invitation-accept/:id', to: 'invitations#accept'

        resources :users, only: %i[index destroy]

        namespace :users do
          resources :boards, only: %i[index]
          resources :components, only: %i[index]
        end
      end

    end
  end

  mount ActionCable.server => '/cable'
end
