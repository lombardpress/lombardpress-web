Rails.application.routes.draw do
  
  

  get 'paragraphs/index'
  get 'paragraphs/xml/:itemid/:pid(/:msslug)' => 'paragraphs#xml'
  get 'paragraphs/info'
  get 'paragraphs/plaintext'
  get 'paragraphs/:itemid/:pid(/:msslug)' => 'paragraphs#show'
  
  

  devise_for :users, controllers: { sessions: "users/sessions", profiles: "users/profiles"}
  
  get 'posts/list' => 'posts#list'
  
  resources :posts
  resources :comments, except: [:new]

  get "comments/new/:itemid(/:pid)" => 'comments#new', as: :new_comment
  get "comments/list/:itemid(/:pid)" => 'comments#list', as: :list_comments
  
  root 'pages#home'

  get '/permissions' => 'pages#permissions'
  
  get 'text' => 'text#index'
  get 'text/questions' => 'text#questions'
  get 'text/info/:itemid' => 'text#info'
  get 'text/status/:itemid' => 'text#status'
  get 'text/toc/:itemid(:/msslug)' => 'text#toc'
  get 'text/xml/:itemid(:/msslug)' => 'text#xml'
  get 'text/:itemid(/:msslug)' => 'text#show'
  
  get 'paragraphimage/:itemid/:msslug/:pid' => 'paragraphimage#show'
  get 'biography' => 'pages#biography'
  get 'bibliography' => 'pages#bibliography' 

  get 'articles/:articleid' => 'articles#show'
  get 'articles' => 'articles#index'
  
  get 'users/profiles' => 'users/profiles#index'
  get 'users/profiles/:id' => 'users/profiles#show'



  

  

  

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
