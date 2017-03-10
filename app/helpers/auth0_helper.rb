module Auth0Helper
  private

  # Is the user signed in?
  # return [Boolean]
  def user_signed_in?
    current_auth0_user.present?
  end

  # Set the @current_user or redirect to public page
  # def authenticate_user!
  #   # Redirect to page that has the login here
  #   if user_signed_in?
  #     @current_user = session[:userinfo]
  #   else
  #     redirect_to login_path
  #   end
  # end

  def current_auth0_user
    session[:userinfo]
  end

  # What's the current_user?
  # return [Hash]
  def current_user
    # this should be:
      # BGoodUser.find_by auth0_id: session[:userinfo][:uid]
    @current_user = BGoodUser.find_by auth0_id: current_auth0_user["uid"] if user_signed_in?
  end

# return user to the login page
  def login_path
    root_path
  end
end
