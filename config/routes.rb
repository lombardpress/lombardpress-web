Rails.application.routes.draw do

  get 'errors/not_found'

  get 'errors/internal_server_error'

  resources :access_requests

  root 'pages#home'

  devise_for :users, controllers: { sessions: "users/sessions", profiles: "users/profiles", registrations: "users/registrations"}

  get 'posts/list' => 'posts#list'
  resources :posts

  resources :comments, except: [:new]

  resources :settings

  #BEGIN routes for error handling
  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all
  #END


  get 'articles/:articleid(/:transcriptionid)' => 'articles#show', as: :show_article
  get 'articles' => 'articles#index', as: :articles

  get 'biography' => 'pages#biography'
  get 'bibliography' => 'pages#bibliography'

  get "comments/new/:itemid(/:pid)" => 'comments#new', as: :new_comment
  get "comments/list/:itemid(/:pid)" => 'comments#list', as: :list_comments

  get "index/(:expressionid)" => 'indices/indices#index'

  get "index/:expressionid/names/list(/:category)" => 'indices/names#list'
  get "index/:expressionid/names/show(/:nameid)" => 'indices/names#show'
  get "index/:expressionid/names/categories" => 'indices/names#categories'

  get "index/:expressionid/titles/list(/:category)" => 'indices/titles#list'
  get "index/:expressionid/titles/show(/:titleid)" => 'indices/titles#show'
  get "index/:expressionid/titles/categories" => 'indices/titles#categories'

  get "index/:expressionid/quotes/list(/:category)" => 'indices/quotes#list'
  get "index/:expressionid/quotes/show(/:quoteid)" => 'indices/quotes#show'
  get "index/:expressionid/quotes/categories" => 'indices/quotes#categories'

scope 'codices' do
  get 'list' => 'codices#list'
  get '(/:shortid)' => 'codices#show'
end
scope 'paragraphs' do
  get 'index' => 'paragraphs#index'
  get 'info' => 'paragraphs#info'
  get 'plaintext' => 'paragraphs#plaintext'
  get 'show2' => 'paragraphs#show2'

  get 'collation/:itemid' => 'paragraphs#collation', as: :paragraphs_collation
  get 'xml/:itemid/:pid(/:msslug)' => 'paragraphs#xml', as: :paragraphs_xml
  get 'json/:itemid/(/:msslug)(/:transcriptslug)' => 'paragraphs#json', as: :paragraphs_json
  get 'variants/:itemid/(/:msslug)(/:transcriptslug)' => 'paragraphs#variants', as: :paragraphs_variants
  get 'notes/:itemid/(/:msslug)(/:transcriptslug)' => 'paragraphs#notes', as: :paragraphs_notes

  get ':itemid/:pid(/:msslug)' => 'paragraphs#show'
end

  get 'permissions' => 'pages#permissions'

  get 'search' => 'search#show', as: :show_search
  get 'search/questions' => 'search#questions', as: :search_questions
  get 'search/index' => 'search#index', as: :show_search_index
scope "text" do
  get '' => 'text#index'
  get 'draft_permissions/:itemid' => 'text#draft_permissions'
  get 'questions(/:resourceid)' => 'text#questions', as: :table_of_questions
  # costraint has to be added because we might have ids with periods in them.
  # this contraint will likely need to be added to other routes above and below
  get 'info/:itemid' => 'text#info', :constraints => { :itemid => /[0-9A-Za-z\-\.]+/ }
  get 'status/:itemid' => 'text#status'
  get 'toc/:itemid(/:msslug)' => 'text#toc'
  get 'plaintext/:itemid(/:msslug)(/:transcriptslug)' =>'text#plain_text', as: :plain_text
  get 'clean/:itemid(/:msslug)(/:transcriptslug)' =>'text#clean', as: :clean
  get 'xml/:itemid(/:msslug)(/:transcriptslug)' => 'text#xml'
  get 'pdf' => 'text#pdf'
  get 'archive' => 'text#archive'
  get ':itemid(/:msslug)(/:transcriptslug)' => 'text#show', as: :show_text
end

  #get 'paragraphimage/showfoliozoom/:msslug/:canvas_id' => 'paragraphimage#showfoliozoom'
  get 'paragraphimage/showfoliozoom' => 'paragraphimage#showfoliozoom'
  get 'paragraphimage/showzoom/:itemid/:msslug' => 'paragraphimage#showzoom'
  #get 'paragraphimage/:itemid/:msslug/:pid' => 'paragraphimage#show'


  get 'users/profiles/:id' => 'users/profiles#show', as: :users_profile
  delete 'users/profiles/:id' => 'users/profiles#destroy', as: :destroy_users_profile
  put 'users/profiles/:id' => 'users/profiles#update', as: :update_users_profile
  post 'users/profiles' => 'users/profiles#create', as: :create_users_profile
  get 'users/profiles' => 'users/profiles#index'

  get 'accesspoints' => 'access_points#index', as: :access_points
  get 'accesspoints/:commentaryid/:itemid/:role' => 'access_points#show', as: :access_point
  post 'accesspoints/:id' => 'access_points#create', as: :create_access_point
  delete 'accesspoints/:id' => 'access_points#destroy', as: :delete_access_point

  ## these route should always go last, all other routes should override it, but if ia resource shortid is used it should take you to the questions page.
  get ':resourceid' => 'text#questions'








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
