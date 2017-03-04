Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,

    callback_path: "/auth/oauth2/callback"
  )
end
