module SpreeBulkStoreCredits
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_bulk_store_credits'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree_bulk_store_credits.assets.precompile' do |app|
      app.config.assets.precompile += %w[
        spree/backend/user_selection_manager.js
        spree/backend/infinite_scroller.js
      ]
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
