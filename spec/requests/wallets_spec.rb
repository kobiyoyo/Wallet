require 'rails_helper'
require_relative '../support/authentication'

RSpec.describe '/wallets', type: :request do
  auth = Auth.new
  let(:user) { FactoryBot.create(:user, role: 'elite', password: '123234566', password_confirmation: '123234566') }
  let!(:currency) { FactoryBot.create(:currency) }
  let!(:wallet) { FactoryBot.create(:wallet, user: user, currency: currency) }
  let(:valid_attributes){{ main: false, user_id: user.id, currency_id: currency.id }}
  let(:invalid_attributes){{transaction_type:'',description:''}}
  let(:transaction) { FactoryBot.create(:transaction) }
  let(:valid_headers) do
    auth.authenticated_header(user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Wallet.create! valid_attributes
      get '/api/v1/wallets', headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      wallet = Wallet.create! valid_attributes
      get "/api/v1/wallets/#{wallet.id}", headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Wallet' do
        expect do
          post '/api/v1/wallets',
               params:  valid_attributes , headers: valid_headers, as: :json
        end.to change(Wallet, :count).by(1)
      end

      it 'renders a JSON response with the new wallet' do
        post '/api/v1/wallets',
             params:  valid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Wallet' do
        expect do
          post '/api/v1/wallets',
               params:  invalid_attributes , headers: valid_headers, as: :json
        end.to change(Wallet, :count).by(0)
      end

      it 'renders a JSON response with errors for the new wallet' do
        post '/api/v1/wallets',
             params:  invalid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do

      it 'renders a JSON response with the wallet' do
        wallet = Wallet.create! valid_attributes
        patch "/api/v1/wallets/#{wallet.id}",
              params:  invalid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the wallet' do
        wallet = Wallet.create! valid_attributes
        patch "/api/v1/wallets/#{wallet.id}",
              params:  invalid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested wallet' do
      wallet = Wallet.create! valid_attributes
      expect do
        delete "/api/v1/wallets/#{wallet.id}", headers: valid_headers, as: :json
      end.to change(Wallet, :count).by(-1)
    end
  end
end
