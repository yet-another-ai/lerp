class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  # FIXME: looks very dangerous, what if it shares credentials props with the client automatically?
  use_inertia_instance_props

  before_action :current_user

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
