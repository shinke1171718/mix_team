Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admins do
    get 'events/new'
    root 'homes#index'
    get 'join_error', to: 'events/members#join_error', as: 'join_error'
    resources :users
    resources :events do
      resources :groups, module: :events
      resources :members, only: [:show], module: :events do
        get 'join', on: :collection
        post 'resend', on: :member
      end
    end
  end

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
  }
end
