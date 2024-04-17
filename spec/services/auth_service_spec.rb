# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AuthService, type: :service do
  let(:repository) { instance_double('UserRepository') }
  let(:auth_service) { AuthService.new(repository) }
  let(:user) { instance_double('User', id: 1, authenticate: true) }

  before do
    allow(repository).to receive(:find_by_email).with('john@example.com').and_return(user)
    allow(repository).to receive(:find).with(user.id).and_return(user)
    allow(user).to receive(:authenticate).with('password').and_return(true)
  end

  describe '#authenticate' do
    it 'authenticates a user and returns a token' do
      expect(auth_service.authenticate('john@example.com', 'password')).to be_a(String)
    end
  end

  describe '#change_password' do
    it 'changes the password of a user' do
      allow(user).to receive(:update).with(password: 'newpassword', password_confirmation: 'newpassword').and_return(true)
      expect(auth_service.change_password(user.id, 'newpassword', 'newpassword')).to be_truthy
    end

    it 'returns false if password confirmation does not match' do
      expect(auth_service.change_password(user.id, 'newpassword', 'wrongconfirmation')).to be false
    end
  end
end
