class SessionsController < ApplicationController
  skip_before_action :require_login, only: [:new, :create, :destroy]

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

  def omniauth
    auth_hash = request.env['omniauth.auth']
    uid_sym = (auth_hash[:provider].to_s + '_uid').to_sym
    user = Friend.find_by(uid_sym => auth_hash[:uid])
    if user
      log_in user
      if params[:origin]
        redirect_to params[:origin]
      else
        redirect_to friend_path(user.id)
      end
    else
      flash.now[:danger] = 'Invalid username or password'
      render 'new'
    end
  end

end
