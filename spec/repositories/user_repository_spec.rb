# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserRepository, type: :repository do
  let(:user_params) { { username: 'john', email: 'john@example.com', password: 'secure123' } }
  let(:user) { User.create!(user_params) }

  before(:each) do
    User.destroy_all
  end

  describe '#find' do
    it 'finds a user by id' do
      expect(described_class.new.find(user.id)).to eq(user)
    end
  end

  describe '#create' do
    it 'creates a new user' do
      expect { described_class.new.create(user_params) }.to change(User, :count).by(1)
    end
  end

  describe '#update' do
    it 'updates a user' do
      repository = described_class.new
      repository.update(user, { email: 'newjohn@example.com' })
      expect(user.reload.email).to eq('newjohn@example.com')
    end
  end

  describe '#destroy' do
    it 'deletes a user' do
      new_user = User.create!(user_params)
      expect { described_class.new.destroy(new_user) }.to change(User, :count).by(-1)
    end
  end

  describe '#find_by_email' do
    it 'finds a user by email' do
      user
      expect(described_class.new.find_by_email('john@example.com').email).to eq('john@example.com')
    end

    it 'returns nil if the user does not exist' do
      expect(described_class.new.find_by_email('nonexistent@example.com')).to be_nil
    end
  end
end
