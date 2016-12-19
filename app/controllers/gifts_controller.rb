class GiftsController < ApplicationController
  before_action :logged_in_user

  def show
    @gift = Gift.find(params[:id])
  end

  def give
    @gift = Gift.new
  end

  def request
    @gift = Gift.new
  end

  def create
    @gift = Gift.create(gift_params)
    if (@gift.save && (@gift.recipient == current_user))
      flash[:success] = "Gift added to wishlist"
      redirect_to current_user
    elsif (@gift.save && (@gift.recipient != current_user))
      render flash[:success] = "Gift saved"
      redirect_to Friend.find_by(name: @gift.recipient)
    elsif (!@gift.save && (@gift.recipient == current_user))
      render 'request'
    else
      render 'give'
    end
  end

  def edit_wish
    @gift = Gift.find(params[:id])

  end

  def update_wish
    @gift = Gift.find(params[:id])
    if @gift.update(gift_params)
      flash[:success] = "Gift updated on wishlist"
      redirect_to(@book)
    else
      render 'edit_wish'
    end
  end

  def edit_purchase
    @gift = Gift.find(params[:id])
  end

  def update_purchase
    @gift = Gift.find(params[:id])
    if @gift.update(gift_params)
      flash[:success] = "Gift updated"
      redirect_to(@book)
    else
      render 'edit_purchase'
    end
  end


  def destroy_purhase
   @gift = Gift.find(params[:id])
   @user = User.find_by(name: @gift.giver)
   if (@gift.asked_for == false)
     @gift.destroy
   else
     @gift.intend_to_give = false
     gift_params[:intend_to_give] = false
     @gift.update(gift_params)
   end
   flash[:success] = "Gift deleted"
   redirect_to @user
 end


  def destroy_wish
    @gift = Gift.find(params[:id])
    @user = User.find_by(name: @gift.recipient)
    if (@gift.intend_to_give == false)
      @gift.destroy
    else
      @gift.asked_for = false
      gift_params[:asked_for] = false
      @gift.update(gift_params)
    end
    flash[:success] = "Gift request deleted"
    redirect_to @user
  end

  private

    def gift_params
      params.require(:title, :description, :recipient, :asked_for, :intend_to_give) .permit(:giver :shipped, :shipping_details, :recieved)
    end

end
