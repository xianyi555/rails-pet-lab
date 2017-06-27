Rails.application.routes.draw do

  root "site#index"

  resources :owners do
    resources :pets, only: [:index, :new, :create]
  end
  resources :pets, only: :show
end

 # rails routes
 #        Prefix Verb   URI Pattern                          Controller#Action
 #          root GET    /                                    site#index
 #    owner_pets GET    /owners/:owner_id/pets(.:format)     pets#index
 #               POST   /owners/:owner_id/pets(.:format)     pets#create
 # new_owner_pet GET    /owners/:owner_id/pets/new(.:format) pets#new
 #        owners GET    /owners(.:format)                    owners#index
 #               POST   /owners(.:format)                    owners#create
 #     new_owner GET    /owners/new(.:format)                owners#new
 #    edit_owner GET    /owners/:id/edit(.:format)           owners#edit
 #         owner GET    /owners/:id(.:format)                owners#show
 #               PATCH  /owners/:id(.:format)                owners#update
 #               PUT    /owners/:id(.:format)                owners#update
 #               DELETE /owners/:id(.:format)                owners#destroy
 #           pet GET    /pets/:id(.:format)                  pets#show
