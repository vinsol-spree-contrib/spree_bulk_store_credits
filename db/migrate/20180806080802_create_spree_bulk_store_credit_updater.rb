class CreateSpreeBulkStoreCreditUpdater < ActiveRecord::Migration[4.2]
  def change
    create_table :spree_bulk_store_credit_updaters do |t|
      t.boolean :job_executed, default: false, null: false
      t.attachment :data_file
    end
  end
end
