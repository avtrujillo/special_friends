class FriendsController < ApplicationController

  def show
    @friend = Friend.find(params[:id])
    @friends = Friend.all
    @gifts = Gift.where(year: Time.christmas_year).reject do |gift|
      gift.recipient_id == current_user.id
    end
  end

  def index
    @friends = Friend.all
    @generations = Generation.all
    @gifts = Gift.where(year: Time.christmas_year).reject do |gift|
      gift.recipient_id == current_user.id
    end
  end

  def recipient
    @friend = current_user.recipient
    @friends = Friend.all
    @gifts = Gift.where(year: Time.christmas_year).reject do |gift|
      gift.recipient_id == current_user.id
    end
    render 'show' and return
  end

  def user
    @friend = current_user
    @friends = Friend.all
    @gifts = Gift.where(year: Time.christmas_year).reject do |gift|
      gift.recipient_id == current_user.id
    end
    render 'show' and return
  end

  def generation
    @generation = Generation.find_by(id: params[:id])
    if @generation
      redirect_to @generation
    else
      render status: 404, file: "#{Rails.root}/public/404.html" and return
    end
  end

  def giving
    if params[:id]
      @giver = Friend.find_by(id: params[:id])
      @gifts = Gift.where(year: Time.christmas_year, giver_id: params[:id]).reject do |gift|
        gift.recipient_id == current_user.id
      end
      render 'gifts/index'
    else
      render status: 404, file: "#{Rails.root}/public/404.html" and return
    end
  end

  def receiving
    if params[:id] == current_user.id
      render status: 403, file: "#{Rails.root}/public/403.html" and return
    elsif params[:id]
      @gifts = Gift.where(year: Time.christmas_year, recipient_id: params[:id])
      render 'gifts/index'
    else
      render status: 404, file: "#{Rails.root}/public/403.html" and return
    end
  end

end
