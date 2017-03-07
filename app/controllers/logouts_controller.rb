class LogoutsController < ApplicationController
  include LogoutsHelper

  def logout
    reset_session
    # redirect_to logout_url.to_s
    redirect_to root_path
  end
end
