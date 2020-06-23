Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users do
        collection do
          post "login"
        end
      end

      resources :images, only: [] do
        collection do
          post "upload"
        end
      end
    end
  end
end
