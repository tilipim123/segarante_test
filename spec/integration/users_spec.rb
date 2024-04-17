# frozen_string_literal: true

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
          username: { type: :string },
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: %w[username email password password_confirmation]
      }

      response '201', 'user created' do
        let(:user) { { username: 'john', email: 'john@example.com', password: '123456', password_confirmation: '123456' } }
        run_test!
      end
    end
  end

  path '/users/{id}' do

    get 'Retrieves a user' do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :string

      response '200', 'user found' do
        let(:id) { User.create(username: 'john', email: 'john@example.com', password: '123456').id }
        run_test!
      end

      response '404', 'user not found' do
        let(:id) { 'invalid' }
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
        }
      }

      response '200', 'user updated' do
        let(:id) { User.create(username: 'john', email: 'john@example.com', password: '123456').id }
        let(:user) { { email: 'newjohn@example.com' } }
        run_test!
      end
    end

    delete 'Deletes a user' do
      tags 'Users'
      parameter name: :id, in: :path, type: :string

      response '204', 'user deleted' do
        let(:id) { User.create(username: 'john', email: 'john@example.com', password: '123456').id }
        run_test!
      end
    end
  end

  path '/change_password' do

    post 'Changes a user\'s password' do
      tags 'Users'
      consumes 'application/json'
      parameter name: :user, in: :body, schema: {
        type: :object,
        properties: {
          id: { type: :integer },
          new_password: { type: :string },
          new_password_confirmation: { type: :string }
        },
        required: %w[id new_password new_password_confirmation]
      }

      response '200', 'password changed' do
        let(:user) { { id: User.create(username: 'john', email: 'john@example.com', password: '123456').id, new_password: 'new123456', new_password_confirmation: 'new123456' } }
        run_test!
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

      response '200', 'authentication successful' do
        schema type: :object,
               properties: {
                 token: { type: :string }
               },
               required: ['token']

        let(:credentials) { { email: 'john@example.com', password: '123456' } }
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
