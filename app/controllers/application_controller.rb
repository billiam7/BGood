class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include Auth0Helper

  before_action :set_referer

  private
  def set_referer
    session[:referer] = params[:referer] if params[:referer]
  end
end
