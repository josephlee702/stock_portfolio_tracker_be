class Api::V1::AuthenticationController < ApplicationController
  require "jwt"

  #POST function - /api/v1/signup
  #this function creates a user and generates a JWT token, which will let the user stay logged into the site
  def signup
    user = User.new(user_params)
    if user.save
      token = generate_jwt_token(user)
      render json: { user: user, token: token }, status: 201
    else
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  #POST /api/v1/login
  #this function verifies the email+password and returns a JWT token
  def login
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = generate_jwt_token(user)
      render json: { user: user, token: token }, status: 200
    else
      render json: { error: "Invalid email or password" }, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def generate_jwt_token(user)
    # {stores user ID into the token, token expires in 24 hours}
    payload = { user_id: user.id, exp: 24.hours.from_now.to_i } 
    # get secret key to sign the token - prevents forgery
    secret = Rails.application.secrets.secret_key_base
    # encoding using HS256 algo
    JWT.encode(payload, secret, 'HS256')
    #function returns a JWT token
  end
end
