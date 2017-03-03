Rails.application.config.middleware.use OmniAuth::Builder do
  provider(
    :auth0,
    'kZb2T8rUqTB82PgRyv20Tj960RNiJQPT',
    'BgrsaZHVCO_pjxP0aYE3qotaBHKpCgmu82EJfkzh9VdHd3y25eNQSIq63d0UF5ld',
    'bgood.auth0.com',
    callback_path: "/auth/oauth2/callback"
  )
end
