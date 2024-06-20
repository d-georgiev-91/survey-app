require 'sidekiq/web'

Rails.application.routes.draw do
  authenticate :user, ->(u) { u.admin? } do
    namespace :admin do
      resources :surveys
    end

    root to: 'admin/surveys#index', as: :authenticated_admin_root
  end

  authenticate :user, ->(u) { !u.admin? } do
    resources :surveys, only: [:index, :edit, :update] do
      member do
        get :finished
      end
    end
  end

  devise_for :users, controllers: { sessions: 'users/sessions' }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  mount Sidekiq::Web => '/sidekiq'

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get 'up' => 'rails/health#show', as: :rails_health_check

  # Defines the root path route ("/")
  root 'surveys#index'
end
