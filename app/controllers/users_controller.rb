class UsersController < ApplicationController

# Login/welcome page
  def show
    @bgood_user = User.new user_params
  end



  private
  def user_params
    params.
      permit(:name,
            :email,
            :phone_number)
  end


end
