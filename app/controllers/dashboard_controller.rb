class DashboardController < ApplicationController
  include Secured
  # before_action :authenticate_user!

  def show
    # auth0 user
    @b_good_user = BGoodUser.new
  end

end
