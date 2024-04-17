# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserService, type: :service do
  let(:repository) { instance_double('UserRepository') }
  let(:user_service) { UserService.new(repository) }
  let(:user) { instance_double('User', id: 1) }

  before do
    allow(repository).to receive(:find).with(user.id).and_return(user)
  end

  describe '#find_user' do
    it 'returns a user' do
      expect(user_service.find_user(user.id)).to eq(user)
    end
  end

  describe '#create_user' do
    it 'creates a user' do
      expect(repository).to receive(:create).with({ username: 'john' }).and_return(user)
      user_service.create_user({ username: 'john' })
    end
  end

  describe '#update_user' do
    it 'updates a user' do
      expect(repository).to receive(:update).with(user, { email: 'new@example.com' }).and_return(user)
      user_service.update_user(user.id, { email: 'new@example.com' })
    end
  end

  describe '#delete_user' do
    it 'deletes a user' do
      expect(repository).to receive(:destroy).with(user)
      user_service.delete_user(user.id)
    end
  end
end
