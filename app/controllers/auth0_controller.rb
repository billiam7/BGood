class Auth0Controller < ApplicationController
  def callback
   # This stores all the user information that came from Auth0
   # and the IdP
   session[:userinfo] = request.env['omniauth.auth']

   # Redirect to the URL you want after successful auth
   if BGoodUser.exists?(auth0_id: (session[:userinfo]['uid']))
     redirect_to dashboard_path
   else
     redirect_to new_b_good_user_path
   end
 end

 def failure
   # show a failure page or redirect to an error page
   @error_msg = request.params['message']
 end
end
