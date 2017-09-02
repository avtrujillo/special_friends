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

end
