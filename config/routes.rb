Inventario::Application.routes.draw do

  get "usuarios/index"

   match "salidas/dar_salida/:articulo_id/verificar_salida/:articulo_id" => "salidas#verificar_salida", :as => :verificar_salida, :via => [:get,:post]

  match "salidas/dar_salida/:articulo_id" => "salidas#dar_salida", :as => :dar_salida

  get "salidas/articulos_salida", :as => :articulos_salida

  get "entradas/index"

  get "entradas/ordenes_entrada", :as => :ordenes_entrada

  match "entradas/dar_entrada/:orden_id" => "entradas#dar_entrada", :as => :dar_entrada

  match "entradas/dar_entrada/:orden_id/verificar_cantidades/:orden_id" => "entradas#verificar_cantidades", :as => :verificar_cantidades, :via => [:get,:post]

  get "salidas/index", :as => :salidas_index

  get "ordenes/index"

get "requisiciones/new"

  get "requisiciones/index"

  get "ordenes/index"

  match "ordenes/crear_orden/:requisicion_id" => "ordenes#crear_orden", :as => :crear_orden, :via => [:get, :post]

  match "ordenes/checar_requisicion/:requisicion_id" => "ordenes#checar_requisicion", :as => :checar_requisicion

  match "requisiciones/finalizar/:requisicion_id" => "requisiciones#finalizar", :as => :finalizar, :via => [:get, :post]

  match "requisiciones/agregar_articulo/:requisicion_id/guardar_datos_articulo/:articulo_id" => "requisiciones#guardar_datos_articulo", :as => :guardar_datos_articulo

  get "requisiciones/seleccionar_proveedor"

  match "requisiciones/agregar_articulo/:requisicion_id/datos_articulo/:articulo_id" => "requisiciones#datos_articulo", :as => :datos_art


   match "requisiciones/crear_requi", :as => :crear_requi, :via => [:get,:post]

 match "requisiciones/agregar_articulo/:requisicion_id/" => "requisiciones#agregar_articulo", :as => :agregar_articulo

 match "requisiciones/agregar_articulo/:requisicion_id/agregar_art_requi/:articulo_id" => "requisiciones#agregar_art_requi", :as => :agregar_art_requi

  get "proveedores/index"

  get "proveedores/new"

  get "inicio/index"

  resources :usuarios

  resources :proveedores

  resources :areas

  resources :articulos




  resource :session, :only => [:new, :create, :destroy]

  match 'signup' => 'usuarios#new', :as => :signup

  match 'register' => 'usuarios#create', :as => :register, :via => [:get, :post]

  match 'login' => 'sessions#new', :as => :login

  match 'logout' => 'sessions#destroy', :as => :logout

  match '/activate/:activation_code' => 'usuarios#activate', :as => :activate, :activation_code => nil

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
 root :to => "inicio#index"

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
