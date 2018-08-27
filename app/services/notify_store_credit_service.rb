require 'csv'
  class NotifyStoreCreditService
    CSV_HEADERS = { 'Email': :Email, 'Store_Credit': :Store_Credit, 'Memo': :Memo, 'Status': :Status }

    def initialize(store_credit_updater_id, admin_email)
      @store_credit_updater = Spree::BulkStoreCreditUpdater.find_by(id: store_credit_updater_id)
      update_store_credits
      @store_credit_updater.update_column(:job_executed, true)
      Spree::StoreCreditUpdaterMailer.update_admin(@csv_export, admin_email, @store_credit_updater.data_file_file_name, @total_records, @successfull_records).deliver_now
      @store_credit_updater.destroy if @store_credit_updater.job_executed?
    end

    private
      def update_store_credits
        @total_records = 0
        @successfull_records = 0
        @csv_export = CSV.generate do |csv|
          unless csv_empty?
            csv << CSV_HEADERS.keys
            CSV.foreach(@store_credit_updater.data_file.path, headers: true) do |row|
              @error = nil
              @total_records += 1
              @row = row
              @user = find_user
              if @user && @row['Store_Credit'].scan(/\D/).empty?
                update_store_credits_with_csv_values
              else
                @error = @user ? Spree.t(:store_credit_not_integer) : Spree.t(:user_not_found)
              end
              csv << set_row
            end
          end
        end
      end

      def csv_empty?
        CSV.readlines(@store_credit_updater.data_file.path) == [[]]
      end

      def set_row
        row = []
        CSV_HEADERS.each do |key, value|
          row << create_csv_row(key, value)
        end
        row
      end

      def create_csv_row(key, value)
        ( key == :Status ) ? error_message : @row[value.to_s]
      end

      def error_message
        @error ? @error : Spree.t(:successfull_update)
      end

      def update_store_credits_with_csv_values
        admin = Spree::User.admin.first
        category = Spree::StoreCreditCategory.first
        store_credit = Spree::StoreCredit.new(amount: @row['Store_Credit'].to_f, created_by_id: admin.id, currency: "USD", category_id: category.try(:id), memo: @row['Memo'])
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

      def find_user
        Spree::User.find_by_email(@row['Email'])
      end
end
