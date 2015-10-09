Rails.application.routes.draw do
  devise_scope :user do
     get "signup-user", to: "users/registrations#new_user"
     get "signup-restaurant", to: "users/registrations#new_rest"
     post "create-user", to: "users/registrations#create_user"
     post "create-restaurant", to: "users/registrations#create_rest"
     get "login", to: "devise/sessions#new"
     get "logout", to: "devise/sessions#destroy"
  end
  devise_for :users, controllers: {registrations: "users/registrations"}
  # get 'sessions/new'

  root 'dynamic_pages#home'

  #with .html
  get 'index.html' => 'dynamic_pages#index'
  get 'signup.html' => 'dynamic_pages#signup'
  get 'login.html' => 'dynamic_pages#login'
  get 'signup-restaurant.html' => 'dynamic_pages#signup_rest'
  # get 'signup-user.html' => 'dynamic_pages#signup_user'
  get 'profile.html' => 'dynamic_pages#profile'
  get 'profile-rest.html' => 'dynamic_pages#profile_resto'

  #without .html
  get 'index' => 'dynamic_pages#index'
  get 'signup' => 'dynamic_pages#signup'
  get 'login' => 'dynamic_pages#login'
  get 'signup-restaurant' => 'dynamic_pages#signup_rest'
  # get 'signup-user' => 'dynamic_pages#signup_user'
  get 'profile' => 'dynamic_pages#profile'
  get 'profile-rest' => 'dynamic_pages#profile_resto'


  #API 
  post 'signupuser' => 'accounts#signupuser'
  post 'signuprest' => 'accounts#signuprest'

  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
