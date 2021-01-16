require 'acceptance_helper'
require_relative '../support/authentication'

resource 'Transactions' do
  auth = Auth.new
  let!(:user) { FactoryBot.create(:user, role: 'admin', password: '123234566', password_confirmation: '123234566') }
  let(:valid_headers) { auth.token(user) }
  let!(:currency) { FactoryBot.create(:currency) }
  let!(:wallet) { FactoryBot.create(:wallet, user: user, currency: currency) }
  let!(:transaction) { FactoryBot.create(:transaction, user: user, wallet: wallet, currency: currency, description: 'phone money i am saving') }
  let(:transaction_id) { transaction.id }
  before do
    header 'Authorization', valid_headers
    header 'Content-Type', 'application/json'
  end

  get 'api/v1/transactions' do
    example_request 'Get all transactions' do
      explanation 'List all the transactions'
      expect(status).to eq 200
    end
  end

  post 'api/v1/transactions' do
    route_summary 'This is used to create a transaction'
    parameter :transaction_type, 'transaction type'
    parameter :description, 'transaction description'
    parameter :amount, 'transaction amount'
    parameter :user_id, 'transaction user_id'
    parameter :wallet_id, 'transaction wallet_id'
    parameter :currency_id, 'transaction currency_id'
    example_request 'Create a transaction' do
      explanation 'Create a transaction'
      do_request(transaction_type: 'deposit', description: 'phone money i am savings', amount: 23.21, user_id: user.id, wallet_id: wallet.id, currency_id: currency.id)
      expect(status).to eq 200
    end
  end

  patch 'api/v1/transactions/:transaction_id' do
    route_summary 'This is used to edit a transaction'
    parameter :confirm, 'transaction confirm'
    example_request 'Edit a transaction' do
      explanation 'Edit a transaction'
      do_request(confirm: true)
      expect(status).to eq 200
    end
  end
  delete 'api/v1/transactions/:transaction_id' do
    example_request 'Delete a transaction' do
      explanation 'Delete a transaction'
      expect(status).to eq 204
    end
  end
end
