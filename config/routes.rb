Rails.application.routes.draw do
  root "tasks#index"
  resources :tasks, only: [ :index, :create, :show, :edit, :update, :destroy ] do
    member do
      patch :toggle_complete
    end
  end

  get "up" => "rails/health#show", as: :rails_health_check
end
