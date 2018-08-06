Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin, path: Spree.admin_path do
    resources :users do
      collection { post :import_store_credits }
      collection { get :sample_store_credit_csv }
    end
  end
end
