# frozen_string_literal: true

OmniAuth.config.logger = Rails.logger
OmniAuth::AuthenticityTokenProtection.default_options(key: "csrf.token", authenticity_param: "_csrf")

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :developer if Rails.env.development?
end
