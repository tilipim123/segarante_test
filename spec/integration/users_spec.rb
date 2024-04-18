# frozen_string_literal: true

# spec/integration/users_spec.rb

require 'swagger_helper'

describe 'Users API' do
  path '/users' do
    get 'Lists all users' do
      tags 'Users'
      produces 'application/json'
      response '200', 'users listed' do
        run_test!
      end
    end

    post 'Creates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          user: {
            type: :object,
            properties: {
              username: { type: :string },
              email: { type: :string },
              password: { type: :string },
              password_confirmation: { type: :string }
            },
            required: %w[username email password password_confirmation]
          }
        }
      }

      response '201', 'user created' do
        let(:user) do
          { username: 'newuser', email: 'user@example.com', password: '123456', password_confirmation: '123456' }
        end
        run_test!
      end
    end
  end

  path '/users/{id}' do
    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string
      let!(:existing_user) { create(:user) }

      response '200', 'user found' do
        let(:id) { existing_user.id.to_s }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'nonexistent' }
        run_test!
      end
    end

    put 'Updates a user' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string }
        },
        required: ['email']
      }

      let!(:existing_user) { create(:user) }
      let(:user) { { email: 'newjohn@example.com' } }

      response '200', 'user updated' do
        let(:id) { existing_user.id }
        run_test!
      end
    end

    delete 'Deletes a user' do
      tags 'Users'
      parameter name: :id, in: :path, type: :string
      let!(:existing_user) { create(:user) }

      response '204', 'user deleted' do
        let(:id) { existing_user.id }
        run_test!
      end
    end
  end

  path '/users/{id}/change_password' do
    patch 'Changes a user\'s password' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :id, in: :path, type: :string
      parameter name: :password_details, in: :body, schema: {
        type: :object,
        properties: {
          new_password: { type: :string },
          new_password_confirmation: { type: :string }
        },
        required: %w[new_password new_password_confirmation]
      }

      let!(:existing_user) { create(:user) }
      let(:id) { existing_user.id.to_s }
      let(:password_details) { { new_password: 'new123456', new_password_confirmation: 'new123456' } }

      response '200', 'password changed' do
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['message']).to eq('Password successfully updated')
        end
      end

      response '422', 'unprocessable entity' do
        let(:password_details) { { new_password: 'new123', new_password_confirmation: 'new123456' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['error']).to eq('Password update failed')
        end
      end
    end
  end

  path '/login' do
    post 'Authenticates a user and returns a token' do
      tags 'Authentication'
      consumes 'application/json'
      parameter name: :credentials, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: %w[email password]
      }

      let!(:existing_user) { create(:user) }
      response '200', 'authentication successful' do
        let(:credentials) { { email: existing_user.email, password: '123456' } }
        run_test! do |response|
          data = JSON.parse(response.body)
          expect(data['token']).not_to be_nil
        end
      end

      response '401', 'invalid credentials' do
        let(:credentials) { { email: 'john@example.com', password: 'wrong' } }
        run_test!
      end
    end
  end
end
