class AmazonController < ApplicationController

  def import
  end

  def create_list
    list = AmazonWishList.wishlist_from_url(params[:wishlist_url])
    fal = FriendAmazonList.create!(external_id: list.id, friend_id: current_user.id)
    @duplicates = []
    @wishes = list.wishes.each_with_object(Array.new) do |wish, arr|
      faw = FriendAmazonWish.create!(external_id: wish.id, friend_id: current_user.id,
      friend_amazon_list_id: fal.id, )
      arr << Wish.create!(friend_amazon_wish_id: faw.id,
        friend_id: current_user.id, title: wish.title, description: wish.url)
    end
    # redirect_to "amazon/show_list/#{fal.id}"
    render 'show_import'
  end

  def show_list
    list = FriendAmazonList.find(params[:id])
    @wishes = list.wishes
    @friend = list.friend
    render 'wishes/index'
    #TODO: replace this with somethin better
  end

end
