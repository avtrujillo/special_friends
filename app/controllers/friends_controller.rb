class FriendsController < ApplicationController

  def show
    @friend = Friend.find(params[:id])
    @friends = Friend.all
    @gifts = Gift.all
  end

  def index
    @friends = Friend.all
    @gifts = Gift.all
  end

  def recipient
    @friend = current_user.recipient
    @friends = Friend.all
    @gifts = Gift.all
    render 'show' and return
  end

  def user
    @friend = current_user
    @friends = Friend.all
    @gifts = Gift.all
    render 'show' and return
  end

  def generation
    @generation = Generation.find_by(id: params[:id])
    if @generation
      render 'show' and return
    else
      redirect_to @generation : render status: 404, file: "#{Rails.root}/public/404.html" and return
    end
  end

end
