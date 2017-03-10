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
    @b_good_user = BGoodUser.new user_params
    @b_good_user.email = session[:userinfo]['info']['email']
    @b_good_user.auth0_id = session[:userinfo]['uid']
    @b_good_user.referer = session[:referer] if session[:referer]
    @b_good_user.save!
    redirect_to dashboard_path, notice: "Thank you for completing your profile."
  end

  private
  def user_params
    params.require(:b_good_user).permit(:name, :email)
  end
end
