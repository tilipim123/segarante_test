# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, type: :controller do
  describe 'POST #create' do
    it 'authenticates the user and returns a token' do
      expect_any_instance_of(AuthService).to receive(:authenticate).with('john@example.com',
                                                                         'password').and_return('token')
      post :create, params: { email: 'john@example.com', password: 'password' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)['token']).to eq('token')
    end
  end
end
