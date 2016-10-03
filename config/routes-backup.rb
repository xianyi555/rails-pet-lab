Rails.application.routes.draw do

  root "site#index"

  resources :owners do
    resources :pets
  end

end
