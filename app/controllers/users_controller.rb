class UsersController < ApplicationController
  def index
    user = User.all
    render json: user, status: :ok
  end

  def show
    user = User.find(params[:id])
    render json: user, status: :ok
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: { message: "User created successfully" }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :bad_request
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    render json: { message: "User deleted successfully" }, status: :ok
  end

  def update
    user = User.find(params[:id])
    if user.update_attributes(user_params)
      render json: { message: "User updated successfully" }, status: :ok
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email].to_s.downcase)
    if user && user.authenticate(params[:password])
      auth_token = JsonWebToken.encode({ user_id: user.id })
      render json: { user: user, auth_token: auth_token }, status: :ok
    else
      render json: { error: "Invalid username / password" }, status: :unauthorized
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
