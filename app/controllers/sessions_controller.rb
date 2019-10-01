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
      flash.now[:success] = 'Linked with Facebook'
      redirect_to '/friends'
    elsif fb
      log_in fb.friend
      redirect_to '/friends'
    else
      # Facebook.from_auth_hash returns false if this facebook profile is already associated
      # with another user
      flash['danger'] = 'Invalid Facebook login'
      redirect_to 'new'
      # TODO: (low priority) for some reason this results in a corrupted content error
    end
  end

end
