require 'acceptance_helper'
require_relative '../support/authentication'

resource 'Authentication' do
  let!(:currency) { FactoryBot.create(:currency) }
  let!(:user) { FactoryBot.create(:user, email: 'rilux@gmail.com', password: '123234566', role: 'admin') }

  before do
    header 'Content-Type', 'application/json'
  end

  post 'auth/signup' do
    route_summary 'This is used to signup a user'
    parameter :first_name, 'User first_name'
    parameter :last_name, 'User last_name'
    parameter :email, 'User email'
    parameter :password, 'User password'
    parameter :currency_id, 'User currency'
    example_request 'Sign up a user' do
      explanation 'Sign up a user'
      do_request(first_name: 'simon', currency_id: currency.id, last_name: 'adama', email: 'simon@gmail.com', password: '123234566')
      expect(status).to eq 200
    end
  end
  post 'auth/signin' do
    route_summary 'This is used to signin a user'
    with_options scope: :auth, with_example: true do
      parameter :email, 'User email'
      parameter :password, 'User password'
    end

    context 'when it successful 200' do
      example 'Sign in user' do
        request = { email: user.email, password: user.password }

        do_request(request)

        expect(status).to eq(200)
      end
    end
  end
end
