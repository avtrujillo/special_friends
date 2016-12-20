class FriendsController < ApplicationController

  def show
    @friend = Friend.find(params[:id])
  end

  def index
    @friends = Friend.all
    @gifts = Gift.all
  end

end
