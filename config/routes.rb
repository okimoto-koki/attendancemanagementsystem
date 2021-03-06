Attendancemanagementsystem2::Application.routes.draw do
  devise_for :users
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'main#index'

  get 'new' => 'main#new'
  get 'index' => 'main#index'
  get 'edit' => 'main#edit'
  post 'update' => 'main#update'
  get 'index_all' => 'main#index_all'
  get 'admin_index' => 'main#admin_index'
  get 'admin_find' => 'main#admin_find'
  get 'admin_result' => 'main#admin_result'
  post 'admin_result' => 'main#admin_result'
  get 'admin_time_config' => 'main#admin_time_config'
  post 'admin_time_config_new' => 'main#admin_time_config_new'
  delete 'admin_time_config_destroy' => 'main#admin_time_config_destroy'
  put 'admin_time_config_active_on' => 'main#admin_time_config_active_on'
  put 'admin_time_config_active_off' => 'main#admin_time_config_active_off'


  resources :main

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
