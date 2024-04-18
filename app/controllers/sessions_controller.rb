# frozen_string_literal: true

# app/controllers/sessions_controller.rb
class SessionsController < ApplicationController
  def create
    token = AuthService.new.authenticate(params[:email], params[:password])
    if token
      render json: { token: token }, status: :ok
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  def change_password
    success = AuthService.new.change_password(params[:id], params[:user][:new_password], params[:user][:new_password_confirmation])
    if success
      render json: { message: 'Password successfully updated' }
    else
      render json: { error: 'Password update failed' }, status: :unprocessable_entity
    end
  end
end
