class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def index
    users = User.all
    render json: users
  end

  def show
    render json: @user
  end

  def create
    user = User.new(user_params)
    if user.save
      render json: user, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: 422
    end
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: {errors: @user.errors.full_messages }, status: 422
    end
  end

  def destroy
    @user.destroy
    render json: { message: "User successfully deleted." }, status: 200
  end

  private

  #eliminates a lot of code in the functions above
  #also has a rescue to account for a case when the user doesn't exist
  def set_user
    @user = User.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: "User was not found." }, status: 404
  end


  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
