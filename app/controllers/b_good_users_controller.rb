class BGoodUsersController < ApplicationController

  def index
    redirect_to dashboard_path
  end

  def show
    redirect_to dashboard_path
  end

  # Login/welcome page
  def new
    @b_good_user = BGoodUser.new
  end

  def create
    @b_good_user = BGoodUser.create user_params
    redirect_to dashboard_path, notice: "Thank you for completing your profile."
  end

  private
  def user_params
    params.require(:b_good_user).permit(:name, :email, :phone_number)
  end
end
