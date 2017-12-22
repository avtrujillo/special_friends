class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include SessionsHelper
  include GiftsHelper
  before_action :require_login

  private

  def require_login
    unless logged_in?
      flash[:error] = 'You must be logged in to view this page'
      redirect_to login_url referer: request.url
    end
  end
end
