Rails.application.routes.draw do
  get 'sessions/new'

  root 'static_pages#index'

  #with .html
  get 'index.html' => 'static_pages#index'
  get 'signup.html' => 'static_pages#signup'
  get 'login.html' => 'static_pages#login'
  get 'signup-restaurant.html' => 'static_pages#signup_rest'
  get 'signup-user.html' => 'static_pages#signup_user'

  #without .html
  get 'index' => 'static_pages#index'
  get 'signup' => 'static_pages#signup'
  get 'login' => 'static_pages#login'
  get 'signup-restaurant' => 'static_pages#signup_rest'
  get 'signup-user' => 'static_pages#signup_user'


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
