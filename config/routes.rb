Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check

  namespace :admins do
    root 'homes#index'
  end

  devise_for :admins, controllers: {
    sessions: 'admins/sessions',
    passwords: 'admins/passwords',
    registrations: 'admins/registrations',
  }
end
