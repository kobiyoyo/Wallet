require 'rails_helper'
require_relative '../support/authentication'


RSpec.describe '/transactions', type: :request do
  auth = Auth.new
  let(:user) { FactoryBot.create(:user, role: 'admin', password: '123234566', password_confirmation: '123234566') }
  let!(:currency) { FactoryBot.create(:currency) }
  let!(:wallet) { FactoryBot.create(:wallet, user: user, currency: currency) }
  let(:valid_attributes){{ transaction_type: 'deposit',status:'approved', description: 'phone money i am savings', amount: 23.21, user_id: user.id, wallet_id: wallet.id, currency_id: currency.id }}
  let(:invalid_attributes){{transaction_type:'',description:''}}
  let(:transaction) { FactoryBot.create(:transaction) }
  let(:valid_headers) do
    auth.authenticated_header(user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Transaction.create! valid_attributes
      get '/api/v1/transactions', headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end


  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Transaction' do
        expect do
          post "/api/v1/transactions/",
               params: valid_attributes , headers: valid_headers, as: :json
        end.to change(Transaction, :count).by(1)
      end

      it 'renders a JSON response with the new transaction' do
        post "/api/v1/transactions/",
             params: valid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Transaction' do
        expect do
          post "/api/v1/transactions/",
               params:  invalid_attributes ,  headers: valid_headers ,as: :json
        end.to change(Transaction, :count).by(0)
      end

      it 'renders a JSON response with errors for the new transaction' do
        post "/api/v1/transactions/",
             params:  invalid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do

      it 'renders a JSON response with the transaction' do
        transaction = Transaction.create! valid_attributes
        patch "/api/v1/transactions/#{transaction.id}",
              params:  invalid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq("application/json; charset=utf-8")
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the transaction' do
        transaction = Transaction.create! valid_attributes
        patch "/api/v1/transactions/#{transaction.id}",
              params:  invalid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested transaction' do
      transaction = Transaction.create! valid_attributes
      expect do
        delete "/api/v1/transactions/#{transaction.id}", headers: valid_headers, as: :json
      end.to change(Transaction, :count).by(-1)
    end
  end
end
