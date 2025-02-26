class Api::V1::AuthenticationController < ApplicationController
  require "jwt"

  #POST function - /api/v1/register
  #this function creates a user and generates a JWT token, which will let the user stay logged into the site
  def register
    user = User.new(user_params)
    if user.save
      token = generate_jwt_token(user)
      render json: { user: user, token: token }, status: 201
    else
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
