Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  scope :api do
    resources :ride
    post '/login', to: 'login#index'
    resources :messages do
      post :talked_to

    scope :api do
      resources :ride
      resources :messages do
        collection do
          post :talked_to
        end
      end    
    end
  end
end
