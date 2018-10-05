require 'spec_helper'

RSpec.describe Spree::BulkStoreCreditUpdater, type: :model do

  describe 'Validations' do
    it { is_expected.to have_attached_file(:data_file) }
    it { is_expected.to validate_attachment_content_type(:data_file).allowing('text/csv', 'text/plain') }
  end
end
