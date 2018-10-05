require 'spec_helper'

describe Spree::Admin::UsersController, type: :controller do
  stub_authorization!
  let!(:user) { create(:user) }

  before { allow(controller).to receive_messages spree_current_user: user }

  describe 'GET #sample_store_credit_csv' do
    before { get :sample_store_credit_csv }

    it { expect(response.headers['Content-Type']).to eq('text/csv') }
    it { expect(response.headers['Content-Disposition']).to eq("attachment; filename=\"bulk_store_credits_example.csv\"") }
    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #import_store_credits' do

  end

  describe 'GET #bulk_store_credits' do
     context 'html request' do
      before { get :bulk_store_credits }
      it { is_expected.to render_template :bulk_store_credits }
      it { expect(response).to have_http_status(200) }
    end

    context 'js request' do
      before { get :bulk_store_credits, xhr: true }
      it { is_expected.to render_template :bulk_store_credits }
      it { expect(response).to have_http_status(200) }
    end
  end

  describe 'POST #update_bulk_credits' do
    let!(:user2) { create(:user, id: '2', email: 'user2@example.com', password: 'user2_pass') }
    let!(:user3) { create(:user, id: '3', email: 'user3@example.com', password: 'user3_pass') }
    context 'success' do
      before { post :update_bulk_credits, params: { credit_value: ['2', '3'] } }
      it {  }
    end

    context 'fail' do
      context 'when no user selected' do
        
      end

      context 'when credit value id non-integer' do
        
      end
    end
  end
end
