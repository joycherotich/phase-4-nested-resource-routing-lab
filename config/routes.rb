Rails.application.routes.draw do
  resources :users do
    resources :items, only: [:index, :show, :create]
  end
end
