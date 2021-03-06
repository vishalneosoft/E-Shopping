Rails.application.routes.draw do
  resources :contacts, only: [ :index, :edit, :create, :update]
  resources :wish_lists, only: [ :index, :create, :destroy]
  resources :addresses, except: [ :show, :destroy]
  resources :check_outs, only: [ :index]
  get 'review_payment', to: 'check_outs#review_payment'
  resources :cart_items, except: [ :show, :new, :edit]
  get 'remove_coupon', to: 'cart_items#remove_coupon'
  get 'apply_coupon', to: 'cart_items#apply_coupon' 
  resources :categories, only: :show do 
    resources :brands, only: [ :show]
  end
  resources :brands, only: [ :index]
  resources :products, only: :show
  resources :orders, except: [ :new, :edit, :update, :destroy] do 
    member do
      get 'payment'
      post 'create_charges'
      get 'cancel_order'
    end
  end
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  get 'home/index'
  root 'home#index'
  get '*unmatched_route' => 'application#routing_error'

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
