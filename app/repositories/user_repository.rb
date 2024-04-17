# frozen_string_literal: true

# app/repositories/user_repository.rb
class UserRepository
  def all
    User.all
  end

  def find(id)
    User.find(id)
  end

  def create(params)
    User.create(params)
  end

  def update(user, params)
    user.update(params)
    user
  end

  def destroy(user)
    user.destroy
  end

  def find_by_email(email)
    User.find_by(email: email)
  end
end
