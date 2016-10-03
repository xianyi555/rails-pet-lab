Rails.application.routes.draw do

  root "site#index"

  resources :owners

end
