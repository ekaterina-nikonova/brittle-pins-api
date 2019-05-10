Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      post 'signup', to: 'signup#create'
      post 'signin', to: 'signin#create'

      resources :boards do
        get 'components' => :components
      end

      resources :uploads

      resources :components
    end
  end
end
