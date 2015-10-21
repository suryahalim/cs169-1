Rails.application.routes.draw do
  resources :restaurants
  resources :customers
  resources :waitlists
  devise_scope :user do
     get "signup-user", to: "users/registrations#new_user"
     get "signup-restaurant", to: "users/registrations#new_rest"
     post "create-user", to: "users/registrations#create_user"
     post "create-restaurant", to: "users/registrations#create_rest"
     delete "destroy-user", to: "users/registrations#destroy"
     get "login", to: "users/sessions#new"
     get "sign_in", to: "users/sessions#new"
     post "sign_in", to: "users/sessions#create"
     get "logout", to: "users/sessions#destroy"
  end
  devise_for :users, controllers: {registrations: "users/registrations"}
  # get 'sessions/new'

  root 'dynamic_pages#home'

  #with .html
  get 'index.html' => 'dynamic_pages#index'
  get 'signup.html' => 'dynamic_pages#signup'
  get 'profile.html' => 'dynamic_pages#profile'

  #without .html
  get 'index' => 'dynamic_pages#index'
  get 'signup' => 'dynamic_pages#signup'
  get 'profile' => 'dynamic_pages#profile'


  #waitlist URL
  get 'waitlists/new/:id' => 'waitlists#new'

  #API 
  # post 'signupuser' => 'users/registrations#new_user'
  # post 'signuprest' => 'users/registrations#new_rest'

  # # get 'login' => 'sessions#new'
  # # post 'login' => 'sessions#create'
  # delete 'logout' => 'sessions#destroy'



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
