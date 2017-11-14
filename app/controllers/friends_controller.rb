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
    redirect_to current_user.recipient
  end

  def giver
    @friend = current_user.giver
    @friends = Friend.all
    @gifts = Gift.all
    render 'giver.html.erb'
  end

  def user
    redirect_to current_user
  end

  def generation
    @generation = Generation.find_by(id: params[:id]) || current_user.generation
    render 'generations/generation.html.erb'
  end

end
