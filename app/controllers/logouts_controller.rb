module LogoutHelper
  def logout_url
    creds = { client_id: ENV['auth0_bgood_key'],
    client_secret: ENV['auth0_bgood_secret'],
    api_version: 1,
    domain: ENV['auth0_domain']}
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
