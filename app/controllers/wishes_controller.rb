class WishesController < ApplicationController
  include ActionController::MimeResponds
  respond_to :html, :json

  def new
  end

  def create
  end

  def index
  end

  def friend_wishes_ajax
    friend_id = params[:id]
    @friend_wishes = Wish.where(year: Time.christmas_year, friend_id: friend_id)
    respond_to do |format|
      format.json { render json: @friend_wishes.to_json }
    end
  end

end
