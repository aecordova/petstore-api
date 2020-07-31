Rails.application.routes.draw do
 namespace :api do
    namespace :v1 do
      resources :pets, only: [:index, :create, :show]
    end
  end
end
