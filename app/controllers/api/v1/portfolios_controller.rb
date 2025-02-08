class Api::V1::PortfoliosController < ApplicationController
  before_action :set_portfolio, only [:show, :update, :destroy]

  def index

  end

  def show

  end

  def create

  end

  def update

  end

  def destroy

  end

  private

  def portfolio_params
    params.require(:portfolio).permit(:name, :user_id)
  end
  
  #designates portfolio to perform show, update and destroy actions on
  def set_portfolio

  end
end