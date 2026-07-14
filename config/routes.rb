Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  post "/register" => "authentication#register"
  post "/login" => "authentication#login"


  # User methods
  resources :users
  post "/users/:id/assign_workspace", to: "users#assign_workspace"

  # Workspace Methods
  resources :workspaces
  get "/workspaces/owner/:owner_id", to: "workspaces#by_owner"

  resources :boards
  # post "/workpsaces/assign_to_user", to: "workspace#assign_to_user"
end
