require 'acceptance_helper'
require_relative '../support/authentication'

resource 'Wallets' do
  auth = Auth.new
  let!(:user) { FactoryBot.create(:user, role: 'elite', password: '123234566', password_confirmation: '123234566') }
  let!(:currency) { FactoryBot.create(:currency) }
  let!(:wallet) { FactoryBot.create(:wallet, user: user, currency: currency) }
  let(:valid_headers) { auth.token(user) }
  let(:wallet_id) { wallet.id }

  before do
    header 'Authorization', valid_headers
    header 'Content-Type', 'application/json'
  end

  get 'api/v1/wallets' do
    example_request 'Get all wallets' do
      expect(status).to eq 200
    end
  end
  get 'api/v1/wallets/:wallet_id' do
    example_request 'Get a wallet' do
      expect(status).to eq 200
    end
  end
  post 'api/v1/wallets' do
    route_summary 'This is used to create a wallet'
    parameter :first_name, 'Wallet first_name'
    parameter :last_name, 'Wallet last_name'
    parameter :email, 'Wallet email'
    parameter :password, 'Wallet password'
    parameter :currency_id, 'Wallet currency'
    example_request 'Create a wallet' do
      do_request(main: false, user_id: user.id, currency_id: currency.id)
      expect(status).to eq 200
    end
  end
  patch 'api/v1/wallets/:wallet_id' do
    route_summary 'This is used to edit a wallet'
    parameter :currency_id, 'Wallet first_name'
    example_request 'Edit a wallet' do
      do_request(currency_id: currency.id)
      expect(status).to eq 200
    end
  end
  delete 'api/v1/wallets/:wallet_id' do
    example_request 'Delete a wallet' do
      expect(status).to eq 204
    end
  end
end
