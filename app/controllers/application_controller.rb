class ApplicationController < ActionController::API
        include DeviseTokenAuth::Concerns::SetUserByToken
  # before_action :authenticate_user, except: [:signup, :login]
  before_action :configure_permitted_parameters, if: :devise_controller?


  def authenticate_user
    header = request.headers["Authorization"]
    token = header.split(" ").last if header.present?
    begin
      decoded_token = JWT.decode(token, Rails.application.credentials.secret_key_base, true, algorithm: "HS256")
      user_id = decoded_token[0]["user_id"]
      @current_user = User.find(user_id)
    rescue JWT::DecodeError, ActiveRecord::RecordNotFound
      render json: { error: "Unauthorized" }, status: 401
    end
  end

  def current_user
    @current_user
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :password, :password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :password, :password_confirmation])
  end
end
