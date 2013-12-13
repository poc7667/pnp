BookStore::Application.routes.draw do
  resources :branches


  resources :customers
  resources :orders
  resources :line_items
  devise_for :users

  root :to=> 'books#index'

  #For search book 
  get "book/search" => "books#search"

  get "book/print_barcode" => "books#print_barcode"
  post "book/print_barcode" => "books#print_barcode"
  resources :books
  resources :carts 

  #不可以寫carts 會跟先前的routes有所衝突, 會被當做 show actions
  get "cart/search" => "carts#search"
  get "cart/search_book" => "carts#search_book"
  #search user
  get "cart/search_customer" => "carts#search_customer"
  get "cart/add_item" => "carts#add_item"
  get "cart/load_customer" => "carts#load_customer"
  post "cart/submit_order" => "carts#submit_order"
  # get "cart/submit_order" => "carts#submit_order"
  

  post "order/show_by_date" => "orders#show_by_date"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
