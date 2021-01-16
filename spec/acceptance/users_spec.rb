require 'acceptance_helper'
require_relative '../support/authentication'

resource 'Users' do
  auth = Auth.new
  let!(:currency) { FactoryBot.create(:currency) }
  let!(:user) { FactoryBot.create(:user, email: 'rilux@gmail.com', password: '123234566', role: 'admin') }
  let(:valid_headers) { auth.token(user) }
  let(:user_id) { user.id }

  before do
    header 'Authorization', valid_headers
    header 'Content-Type', 'application/json'
  end

  get 'api/v1/users' do
    example_request 'Get all users' do
      expect(status).to eq 200
    end
  end
  get 'api/v1/users/:user_id' do
    example_request 'Get a user' do
      expect(status).to eq 204
    end
  end
  post 'api/v1/users' do
    route_summary 'This is used to create a user'
    parameter :first_name, 'User first_name'
    parameter :last_name, 'User last_name'
    parameter :email, 'User email'
    parameter :password, 'User password'
    parameter :currency_id, 'User currency'
    example_request 'Create a user' do
      do_request(first_name: 'simon', currency_id: currency.id, last_name: 'adama', email: 'simon@gmail.com', password: '123234566')
      expect(status).to eq 200
    end
  end
  patch 'api/v1/users/:user_id' do
    route_summary 'This is used to edit a user'
    route_summary 'This is used to create a user'
    parameter :active, 'User first_name'
    parameter :role, 'User last_name'
    example_request 'Edit a user' do
      do_request(role: 'admin', active: true)
      expect(status).to eq 200
    end
  end
end
