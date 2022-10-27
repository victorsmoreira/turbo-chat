Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  resources :rooms do
    # resources :messages
  end

  resource :about, only: :show

  root "rooms#index"
end
