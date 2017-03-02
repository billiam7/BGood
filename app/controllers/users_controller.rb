class UsersController < ApplicationController

# Login/welcome page
  def index
    @user = User.new
  end


end
