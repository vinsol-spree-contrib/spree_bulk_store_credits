Spree::Core::Engine.add_routes do
  # Add your extension routes here
  namespace :admin, path: Spree.admin_path do
    resources :users do
      collection do
        post :import_store_credits
        get :sample_store_credit_csv
        get :bulk_store_credits
        post :update_bulk_credits
      end
    end
  end
end
