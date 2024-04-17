# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user_service) { instance_double('UserService') }
  let(:user) { double('User', id: 1, username: 'john', email: 'john@example.com') }

  before do
    allow(UserService).to receive(:new).and_return(user_service)
  end

  describe 'GET #index' do
    it 'returns a success response' do
      expect(user_service).to receive(:list_users).and_return([user])
      get :index
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq([user.as_json])
    end
  end

  describe 'GET #show' do
    it 'returns a user' do
      expect(user_service).to receive(:find_user).with('1').and_return(user)
      get :show, params: { id: '1' }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(user.as_json)
    end

    it 'returns not found when the user does not exist' do
      expect(user_service).to receive(:find_user).with('999').and_return(nil)
      get :show, params: { id: '999' }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { username: 'newuser', email: 'new@example.com', password: 'password', password_confirmation: 'password' } }

    it 'creates a new User' do
      expect(user_service).to receive(:create_user).with(valid_attributes.stringify_keys).and_return(user)
      post :create, params: { user: valid_attributes }
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)).to eq(user.as_json)
    end

    it 'returns status code 422 on failure' do
      expect(user_service).to receive(:create_user).with(valid_attributes.stringify_keys).and_return(nil)
      post :create, params: { user: valid_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT #update' do
    let(:update_attributes) { { email: 'update@example.com' } }

    it 'updates the user' do
      expect(user_service).to receive(:update_user).with('1', update_attributes.stringify_keys).and_return(user)
      put :update, params: { id: '1', user: update_attributes }
      expect(response).to have_http_status(:ok)
      expect(JSON.parse(response.body)).to eq(user.as_json)
    end

    it 'returns status code 422 on failure' do
      expect(user_service).to receive(:update_user).with('1', update_attributes.stringify_keys).and_return(nil)
      put :update, params: { id: '1', user: update_attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the user' do
      expect(user_service).to receive(:delete_user).with('1').and_return(true)
      delete :destroy, params: { id: '1' }
      expect(response).to have_http_status(:no_content)
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
