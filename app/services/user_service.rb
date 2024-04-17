# frozen_string_literal: true

# app/services/user_service.rb
class UserService
  def initialize(repository = UserRepository.new)
    @repository = repository
  end

  def list_users
    @repository.all
  end

  def find_user(id)
    @repository.find(id)
  end

  def create_user(params)
    @repository.create(params)
  end

  def update_user(id, params)
    user = @repository.find(id)
    @repository.update(user, params)
  end

  def delete_user(id)
    user = @repository.find(id)
    @repository.destroy(user)
  end
end
