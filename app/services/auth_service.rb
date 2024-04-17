# frozen_string_literal: true

# app/services/auth_service.rb
class AuthService
  def initialize(user_repository = UserRepository.new)
    @user_repository = user_repository
  end

  def authenticate(email, password)
    user = @user_repository.find_by_email(email)
    return nil unless user&.authenticate(password)

    generate_token(user)
  end

  def generate_token(user)
    JWT.encode({ user_id: user.id, exp: 24.hours.from_now.to_i }, Rails.application.secrets.secret_key_base, 'HS256')
  end

  def change_password(user_id, new_password, new_password_confirmation)
    user = @user_repository.find(user_id)
    return false unless new_password == new_password_confirmation

    user.update(password: new_password, password_confirmation: new_password_confirmation)
  end
end
