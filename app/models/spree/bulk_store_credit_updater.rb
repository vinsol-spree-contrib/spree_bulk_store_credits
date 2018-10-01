module Spree
  class BulkStoreCreditUpdater < Spree::Base

    USER_PER_PAGE = 15

    has_attached_file :data_file
    validates_attachment :data_file, content_type: { content_type: ["text/csv", "text/plain"] }
  end
end
