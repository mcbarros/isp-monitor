Rails.application.routes.draw do
  get "default_routes/index"

  resources :router_configs, except: :show do
    put "default_routes/:route_id", on: :member, to: "default_routes#update", as: :update_route
    get "default_routes/:route_id/history", on: :member, to: "default_routes#history", as: :route_history
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  # Defines the root path route ("/")
  root "default_routes#index"
end
