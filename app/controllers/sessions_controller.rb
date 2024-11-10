class SessionsController < ApplicationController
  def create
    @user = create_user_session
    login(@user)

    respond_to do |format|
      format.html { redirect_to root_path }
    end
  end

  def index
    respond_to do |format|
      format.html { redirect_to user_path(current_user.id) }
    end
  end

  def destroy
    logout

    respond_to do |format|
      format.html { redirect_to auth_index_path }
      format.json { head :no_content }
    end
  end

  private

  def create_user_session
    user = create_by_oauth

    user
  end

  def create_by_oauth
    user_info = request.env["omniauth.auth"]
    return nil if user_info.blank?

    # p user_info

    email = user_info.info.email

    user = User.find_or_create_by(email:)
    # user.update!(groups:)
    user
  end
end
