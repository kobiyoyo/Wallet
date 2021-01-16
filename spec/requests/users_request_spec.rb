require 'rails_helper'

RSpec.describe 'Users', type: :request do
	 auth = Auth.new
  let(:user) { FactoryBot.create(:user, role: 'elite', password: '123234566', password_confirmation: '123234566') }
  let!(:currency) { FactoryBot.create(:currency) }
  let!(:wallet) { FactoryBot.create(:wallet, user: user, currency: currency) }
  let(:valid_attributes){{ first_name: 'simon',last_name: 'adama', email: 'simon@gmail.com', password: '123234566'}}
  let(:post_valid_attributes){{ first_name: 'simon',last_name: 'adama', email: 'simon@gmail.com', password: '123234566',currency_id: currency.id}}
  let(:invalid_attributes){{transaction_type:'',description:''}}
  let(:transaction) { FactoryBot.create(:transaction) }
  let(:valid_headers) do
    auth.authenticated_header(user)
  end
  describe 'GET /index' do
    it 'renders a successful response' do
      User.create! valid_attributes
      get '/api/v1/users', headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      user = User.create! valid_attributes
      get "/api/v1/users/#{user.id}", headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do

      it 'creates a new User' do
        expect do
          post '/auth/signup',
               params:  post_valid_attributes , headers: valid_headers, as: :json
        end.to change(User, :count).by(1)
      end

      it 'renders a JSON response with the new user' do
        post '/api/v1/users',
             params:  valid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including('application/json; charset=utf-8'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new User' do
        expect do
          post '/api/v1/users',
               params:  invalid_attributes , headers: valid_headers, as: :json
        end.to change(User, :count).by(0)
      end

    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do

      it 'renders a JSON response with the user' do
        user = User.create! valid_attributes
        patch "/api/v1/users/#{user.id}",
              params:  invalid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end

    context 'with invalid parameters' do
      it 'renders a JSON response with errors for the user' do
        user = User.create! valid_attributes
        patch "/api/v1/users/#{user.id}",
              params:  invalid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end


end
