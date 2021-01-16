require 'acceptance_helper'
require_relative '../support/authentication'

resource 'Currencies' do
  auth = Auth.new
  let!(:user) { FactoryBot.create(:user, role: 'admin', password: '123234566', password_confirmation: '123234566') }
  let(:valid_headers) { auth.token(user) }

  before do
    header 'Authorization', valid_headers
    header 'Content-Type', 'application/json'
  end

  get 'api/v1/currencies' do
    example_request 'Get all currencies' do
      explanation 'List all the currencies'
      expect(status).to eq 200
    end
  end

  post 'api/v1/currencies' do
    route_summary 'This is used to create a currency'
    parameter :name, 'currency name'
    parameter :abbreviation, 'currency abbreviation'
    example_request 'Create a currency' do
      explanation 'Create a currency'
      do_request(name: 'U.S Dollar', abbreviation: 'USD')
      expect(status).to eq 201
    end
  end
end
