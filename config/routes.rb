Rails.application.routes.draw do
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  # resource :session, controller: "clearance/sessions", only: [:create]
  resource :session, only: [:create]

  # remove the controller to "clearance/users"
  resources :users, only: [:create, :show, :edit, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]


  end

  # get '/users/:id' => 'users#show', as: 'user'
  # get '/users/:id/edit' => 'users#edit', as: 'edit_user'
  # patch '/users/:id' => 'users#update'

  get '/users/:id/edit_profile_pic' => 'users#edit_profile_pic', as: 'edit_profile_pic'
  # patch '/users/:id/profile_pic' => 'users#update_profile_pic'

  get '/users/:id/reservations' => 'reservations#user_reservations', as: 'user_reservations'
  get '/users/:id/listings' => 'listings#user_listings', as: 'user_listings'


  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  get 'static/index'

  get 'static/home' => "static#home", as: "home"
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  root 'static#index'

  # Omniauth
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"


  # Listing routes
  # get '/listings' => 'listings#index'
  # get '/listings/new' => 'listings#new'
  # post '/listings' => 'listings#create'
  # get '/listings/:id' => 'listings#show'
  # get '/listings/:id/edit' => 'listings#edit'
  # patch '/listings/:id' => 'listings#update'
  # delete '/listings/:id' => 'listings#delete'

  resources :listings do
    resources :reservations, only: [:create]

  end
  post 'listings/:id' => 'listings#verify', as: "verify"
  get '/listings/:id/upload_photos' => 'listings#upload_photos', as: 'upload_photos'

  get '/tags/:tag' => 'listings#index', as: "tag"


  resources :reservations , only: [:destroy]



  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
