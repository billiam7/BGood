class BGoodUsersController < ApplicationController

# Login/welcome page
  def show
    @b_good_user = BGoodUser.new user_params
  end



  private
  def user_params
    params.
      permit(:name,
            :email,
            :phone_number)
  end


end
