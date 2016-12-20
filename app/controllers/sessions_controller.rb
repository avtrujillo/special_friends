class SessionsController < ApplicationController

  def new
  end

  def create
    user = Friend.find_by(name: params[:session][:name.capitalize])
    if user
      log_in user
      redirect_to friend_path(user.id)
    else
      flash.now[:danger] = 'Invalid username'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

end
