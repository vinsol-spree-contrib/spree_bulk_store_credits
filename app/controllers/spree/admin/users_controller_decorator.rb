Spree::Admin::UsersController.class_eval do
  def sample_store_credit_csv
    send_file STORE_CREDIT_CSV_FILE[:sample_store_credit_file]
  end

  def import_store_credits
    begin
      create_store_credit_updater
      redirect_to admin_users_path, notice: Spree.t(:email_sent, filename: @store_credit_updater.data_file_file_name)
    rescue
      redirect_to admin_users_path, notice: Spree.t(:invalid_format)
    end
  end

  def bulk_store_credits
    @search = Spree::User.ransack(params[:q])
    @collection = @search.result.present? ? @search.result.page(params[:page]).per(Spree::BulkStoreCreditUpdater::USER_PER_PAGE) : Spree::User.page(params[:page]).per(Spree::BulkStoreCreditUpdater::USER_PER_PAGE)
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update_bulk_credits
    begin
      list_store_credit_updater
      redirect_to admin_users_path, notice: Spree.t(:email_sent_for_users_credit)
    rescue
      redirect_to admin_users_path, notice: Spree.t(:integer_value_only)
    end
  end

  private

    def create_store_credit_updater
      @store_credit_updater = Spree::BulkStoreCreditUpdater.create(data_file: params[:file])
      if @store_credit_updater.valid?
        NotifyStoreCreditService.delay(run_at: 1.minutes.from_now).new(@store_credit_updater.id, try_spree_current_user.email)
      else
        raise 'Invalid Format Exception'
      end
    end

    def list_store_credit_updater
      if params[:credit_value].scan(/\D/).empty?
        ListStoreCreditUpdater.delay(run_at: 1.minutes.from_now).new(params[:users].reject(&:empty?), try_spree_current_user.email, params[:credit_value])
      else
        raise 'Please Enter Integer Value as Credit Value'
      end
    end
end
