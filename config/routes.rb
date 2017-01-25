Rails.application.routes.draw do

  root "site#index"

  resources :owners do
    resources :pets, only: [:index, :new, :create]
  end

  get "/owners/:owner_id/appointments", to: "owners#appointments", as: "owner_appointments"

  resources :pets, only: [:show, :edit, :update, :destroy] do
    resources :appointments, only: [:new, :create]
  end

end
