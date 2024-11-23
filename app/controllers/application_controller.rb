class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  around_action :locale_context

  # FIXME: looks very dangerous, what if it shares credentials props with the client automatically?
  use_inertia_instance_props

  inertia_share current_locale: -> { I18n.locale }
  inertia_share current_user: -> { current_user }

  def locale_context(&)
    locale = session[:locale] || I18n.default_locale # DO NOT store locale in session, this will break RESTful API
    I18n.with_locale(locale, &)
  end

  def current_user
    @current_user ||= User.where(id: session[:user_id])&.first if session[:user_id]
  end

  def login(user)
    user.update(last_login_at: Time.current)
    session[:user_id] = user.id
  end

  def logout
    session[:user_id] = nil
  end
end
