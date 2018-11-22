class AmazonController < ApplicationController

  def import
  end

  def create_list
    list = AmazonWishList.wishlist_from_url(params[:wishlist_url])
    @fal = nil
    unless @fal = FriendAmazonList.find_by(external_id: list.id)
      @fal = FriendAmazonList.create!(external_id: list.id, friend_id: current_user.id)
    end
    @wish_failures = []
    @wish_successes = []
    @wishes = list.wishes.each do |wish|
      next unless wish
      duplicate = !!FriendAmazonWish.find_by(external_id: wish.asin, friend_id: current_user.id)
      faw = FriendAmazonWish.create(external_id: wish.asin, friend_id: current_user.id,
      friend_amazon_list_id: @fal.id)
      if faw
        wish_result = Wish.create(friend_amazon_wish_id: faw.id,
          friend_id: current_user.id, title: wish.title, description: wish.url)
        if !wish_result || duplicate
          @wish_failures << wish_result
        else
          @wish_successes << wish_result
        end
      end
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
