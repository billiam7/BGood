module LogoutHelper
  def logout_url
    creds = { client_id: Rails.application.secrets.auth0_client_id,
    client_secret: Rails.application.secrets.auth0_client_secret,
    api_version: 1,
    domain: Rails.application.secrets.auth0_domain}
    auth0_client = Auth0Client.new(creds)
    auth0_client.logout_url(root_url)
  end
end


class LogoutsController < ApplicationController
  include LogoutHelper
  def logout
    reset_session
    redirect_to logout_url.to_s
  end
end
