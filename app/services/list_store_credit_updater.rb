require 'csv'
  class ListStoreCreditUpdater
    CSV_HEADERS = { 'Email': :Email, 'Store_Credit': :Store_Credit, 'Status': :Status }

    def initialize(users_ids, admin_email, credit_value)
      @admin_email = admin_email
      @users_ids = users_ids
      @credit_value = credit_value
      update_store_credits
      Spree::StoreCreditUpdaterMailer.update_admin(@csv_export, @admin_email, 'Store Credit', @total_records, @successfull_records).deliver_now
    end

    private
      def update_store_credits
        @total_records = 0
        @successfull_records = 0
        @csv_export = CSV.generate do |csv|
          csv << CSV_HEADERS.keys
          @users_ids.each do |user_id|
            @error = nil
            @total_records += 1
            @user = Spree::User.find_by_id (user_id.to_i)
            if @user
              update_store_credits_with_credit_value
            else
              @error = Spree.t(:user_not_found)
            end
            csv << set_row
          end
        end
      end

      def set_row
        row = []
        CSV_HEADERS.each do |key, value|
          if key == :Store_Credit
            row << @credit_value
          else
            row << create_csv_row(key, value)
          end
        end
        row
      end

      def create_csv_row(key, value)
        ( key == :Status ) ? error_message : @user.try(:email)
      end

      def error_message
        @error ? @error : Spree.t(:successfull_update)
      end

      def update_store_credits_with_credit_value
        admin = Spree::User.find_by_email @admin_email
        category = Spree::StoreCreditCategory.first
        store_credit = Spree::StoreCredit.new(amount: @credit_value.to_f, created_by_id: admin.try(:id), currency: "USD", category_id: category.try(:id), memo: Spree.t(:admin_added_via_list))
        @user.store_credits << store_credit
        set_error_message(store_credit)
      end

      def set_error_message(store_credit)
        if store_credit.valid?
          @error = nil
          @successfull_records += 1
        else
          @error = store_credit.errors.full_messages.join(',')
        end
      end
end
