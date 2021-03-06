Marketplace::Application.routes.draw do |map|


  resources :comments

  get "professors/show"

  get "pages/constructing"
  get "pages/search"
  get "categories/show"
  get "autocomplete_searches/Index"

  match '/new_sell',:to=>"items#new_sell"
  match '/new_buy',:to=>"items#new_buy"
  match '/items/subcategories_by_category', :to=>"items#subcategories_by_category"

	map.resources :professors, :member=>{:create_tag=>:put}
  map.resources :items, :collection=>{:update_all=>:put,:new_sell=>:get,:new_buy=>:get}
  map.resources :items, :member=>{:notify=>:get}
  resources :users
  resources :categories
  resources :autocomplete_searches, :only => [:index], :as => 'autocomplete'
  resources :books
  
  
  match "/signout" => "sessions#destroy", :as => :signout  
  match "/auth/:provider/callback" => "sessions#create"  

   root :to => 'items#index'




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
  # root :to => "welcome#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
