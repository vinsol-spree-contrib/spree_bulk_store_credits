module Spree
  class StoreCreditUpdaterMailer < BaseMailer
    def update_admin(status_csv, admin_email, filename, total_records, successfull_records)
      @total_records = total_records
      @failed_records = total_records - successfull_records
      attachments['stock_items.csv'] = status_csv
      subject = "#{Spree::Store.current.name} import of #{ filename } has finished"
      mail(to: 'himanshu.mishra@vinsol.com', from: from_address, subject: subject)
    end
  end
end
