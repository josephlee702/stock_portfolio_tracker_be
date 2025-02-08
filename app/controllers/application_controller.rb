class ApplicationController < ActionController::API
  before_action :authenticate_user, except: [:signup, :login]

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
end
