Spree::Admin::UsersController.class_eval do
  def sample_store_credit_csv
    send_file STORE_CREDIT_CSV_FILE[:sample_store_credit_file]
  end

  def import_store_credits
    begin
      create_store_credit_updater
      redirect_to admin_users_path, notice: Spree.t(:email_sent, filename: @store_credit_updater.data_file_file_name)
    rescue
      redirect_to admin_users_path, notice: "Invalid CSV file format."
    end
  end

  private

    def create_store_credit_updater
      @store_credit_updater = Spree::BulkStoreCreditUpdater.create(data_file: params[:file])
      NotifyStoreCreditService.delay(run_at: 1.minutes.from_now).new(@store_credit_updater.id, try_spree_current_user.email)
    end

end
