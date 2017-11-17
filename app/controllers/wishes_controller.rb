class WishesController < ApplicationController
  include ActionController::MimeResponds
  respond_to :html, :json

  def new
  end

  def create
  end

  def show
    @wish = Wish.find_by(id: params[:id])
    if params[:friend_id] && params[:friend_id] != @wish.friend_id
      render status: 404, file: "#{Rails.root}/public/404.html" and return
    end
  end

  def index
    @friend = Friend.find_by(id: params[:friend_id]) if params[:friend_id]
    @wishes = (@friend) ? Wish.where(friend_id: @friend.id) : Wish.all
  end

  def friend_wishes_ajax
    friend_id = params[:id]
    @friend_wishes = Wish.where(year: Time.christmas_year, friend_id: friend_id)
    respond_to do |format|
      format.json { render json: @friend_wishes.to_json }
    end
  end

end
