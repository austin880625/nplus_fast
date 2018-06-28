Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    resources :ride
    post '/login', to: 'user#login'
    get '/logout', to: 'user#logout'
    get '/me', to: 'user#me'
    put '/me', to: 'user#update'
    get '/user/:id', to: 'user#show'
    resources :messages do
      member do
        post :show
        post :send_msg
      end
      collection do
        post :talked_to
      end
    end

  end
end
