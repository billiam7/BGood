Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    ENV['auth0_bgood_key'],
    ENV['auth0_bgood_secret'],
    ENV['auth0_domain'],
    callback_path: "/auth/oauth2/callback"
  )
end
