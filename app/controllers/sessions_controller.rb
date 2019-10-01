class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :destroy, :omniauth, :facebook]

  def new
    if current_user
      redirect_to friends_path
    end
    @referer = params[:referer]
  end

  def create
    user = Friend.find_by(name: params[:session][:name].capitalize)
    if user && user.authenticate(params[:session][:password])
      log_in user
      if params[:session][:referer]
        redirect_to params[:session][:referer]
      else
        redirect_to friend_path(user.id)
      end
    else
      flash.now[:danger] = 'Invalid username or password'
      render 'new'
    end
  end

  def destroy
    log_out
    redirect_to root_url
  end

  def facebook
    friend_id = current_user.id if current_user
    fb = Facebook.from_auth_hash(request.env['omniauth.auth'], friend_id)
    if fb && current_user
      fb.update(friend_id: current_user.id)
      redirect_to friends_path, notice: 'Linked with Facebook'
    elsif fb && fb.friend
      log_in fb.friend
      redirect_to friends_path
    elsif fb && fb.friend.nil? && current_user.nil?
      redirect_to '/login', alert: 'The facebook profile you are logged into is not associated with a user of this site.' +
          'Please log to this site using your username and password first, or contact the admin'
    elsif current_user && !fb
      # Facebook.from_auth_hash returns false if this facebook profile is already associated
      # with another user
      redirect_to friends_path, alert:'Error: The facebook account you attempted to log in with is already associated with different user'
    else
      raise
    end
  end

end
