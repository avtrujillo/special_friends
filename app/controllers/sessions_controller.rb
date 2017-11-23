class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :destroy]

  def new
    if current_user
      redirect_to friends_path
    end
  end

  def create
    user = Friend.find_by(name: params[:session][:name].capitalize)
    if user && user.authenticate(params[:session][:password])
      log_in user
      redirect_to friend_path(user.id)
    else
      flash.now[:danger] = 'Invalid username or password'"
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
