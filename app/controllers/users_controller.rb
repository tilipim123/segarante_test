# frozen_string_literal: true

# app/controllers/users_controller.rb
class UsersController < ApplicationController
  before_action :set_user_service

  def index
    users = @user_service.list_users
    render json: users
  end

  def show
    user = @user_service.find_user(params[:id])
    render json: user
  end

  def create
    user = @user_service.create_user(user_params)
    render json: user, status: :created
  end

  def update
    user = @user_service.update_user(params[:id], user_params)
    render json: user
  end

  def destroy
    @user_service.delete_user(params[:id])
    head :no_content
  end

  private

  def set_user_service
    @user_service = UserService.new
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
