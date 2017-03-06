module Secured
  extend ActiveSupport::Concern

  included do
    before_action :logged_in_using_omniauth?
  end

  def logged_in_using_omniauth?
    redirect_to '/' unless session[:userinfo].present?
  end
end


class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = current_user
    @bgood_user = User.new
  end

  include Secured

  def index
  end



  def loggedin
  end

end
