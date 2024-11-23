class LocaleController < ApplicationController
  def update
    session[:locale] = params.require(:locale)

    # redirect to caller path
    respond_to do |format|
      format.html { redirect_to request.referer }
      format.json { render status: :ok }
    end
  end
end
