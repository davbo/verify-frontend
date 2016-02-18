Rails.application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  post 'SAML2/SSO' => 'saml#request_post'

  get 'service-status', to: 'service_status#index', as: :service_status

  if ['test', 'development'].include? Rails.env
    get 'test-saml' => 'test_saml#index'
  end

  localized do
    get 'start', to: 'start#index', as: :start
    post 'start', to: 'start#request_post', as: :start

    if Rails.env == 'development'
      get 'sign_in', to: redirect('http://localhost:50190/sign-in')
      get 'about', to: redirect('http://localhost:50190/about')
      get 'confirm_your_identity', to: redirect('http://localhost:50190/confirm-your-identity')
      get 'feedback', to: redirect('http://localhost:50190/feedback')
    else
      get 'sign_in', to: 'sign_in#index', as: :sign_in
      get 'about', to: 'about#index', as: :about
      get 'confirm_your_identity', to: 'confirm_your_identity#index', as: :confirm_your_identity
      get 'feedback', to: 'feedback#index', as: :feedback
    end
  end

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
