require 'rails_helper'
require_relative '../support/authentication'



RSpec.describe '/currencies', type: :request do

  auth = Auth.new
  let(:user) { FactoryBot.create(:user, role: 'admin', password: '123234566', password_confirmation: '123234566') }
  let(:valid_attributes){{ name: 'U.S Dollar', abbreviation: 'USD' }}
  let(:invalid_attributes){{name:''}}
  let(:valid_headers) do
    auth.authenticated_header(user)
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      Currency.create! valid_attributes
      get '/api/v1/currencies', headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end



  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new Currency' do
        expect do
          post '/api/v1/currencies',
               params:  valid_attributes , headers: valid_headers, as: :json
        end.to change(Currency, :count).by(1)
      end

      it 'renders a JSON response with the new currency' do
        post '/api/v1/currencies',
             params: valid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including('application/json'))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new Currency' do
        expect do
          post '/api/v1/currencies',
               params: invalid_attributes,headers: valid_headers, as: :json
        end.to change(Currency, :count).by(0)
      end

      it 'renders a JSON response with errors for the new currency' do
        post '/api/v1/currencies',
             params: invalid_attributes , headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json; charset=utf-8')
      end
    end
  end

end
