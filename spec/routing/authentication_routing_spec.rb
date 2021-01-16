require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :routing do
  describe 'routing' do
    it 'routes to #create' do
      expect(post: 'auth/signup').to route_to('api/v1/users#create')
    end

    it 'routes to #login ' do
      expect(post: 'auth/signin').to route_to('api/v1/users#login')
    end
  end
end
