class GiftsController < ApplicationController
  before_action :current_user # to do: should all_instances go here?

  def show
    @gift = Gift.find(params[:gift][:id])
    all_instances
    if @gift.recipient == @current_user # to do: make sure this works
      render 'user_gift' # to do: make this
    end
  end

  def index
    all_instances
    if params[:friend] && params[:friend][:name] == @current_user[:name]
      @friend = @current_user
      @receiving_gifts = Gift.where(recipient: @current_user)
      @giving_gifts = Gift.where(giver: @current_user)
      render 'user_gifts' # to do: make this
    elsif params[:friend]
      @friend = Friend.find(params[:friend][:id])
      @receiving_gifts = Gift.where(recipient: @friend)
      @giving_gifts = Gift.where(giver: @friend)
      @user_gifts = Gift.where(recipient: @current_user, giver: @friend)
      render 'friend_gifts' # to do: make this
    else
      @friends_receiving_gifts = Friend.each_with_object(Hash.new([])) do |friend, ghash|
        ghash[friend[:id]] == Gift.where(recipient: friend[:id])
      end
      @friends_giving_gifts = Friend.each_with_object(Hash.new([])) do |friend, ghash|
        ghash[friend[:id]] == Gift.where(giver: friend[:id])
      end
      render 'index' # to do: make this
    end
  end

  def new
    @gift = Gift.new
    all_instances
    @wish = Wish.find(params[:wish][:id]) if params[:wish]
    @recipient = Friend.find(params[:friend][:id]) if params[:friend]
    @giver = @current_user
  end

  def create
    all_instances
    @gift = Gift.create(gift_params)
    if (@gift.recipient != @current_user) && @gift.save
      flash[:success] = 'Gift saved'
      redirect_to Friend.find_by(name: @gift.recipient)
      # to do: customize this by the incoming url
    elsif @gift.recipient == @current_user
      flash[:danger] = "You can't give a gift to yourself"
      render 'give'
      # to do: customize this by the incoming url
    else
      flash[:danger] = "Gift not saved"
      render 'give'
      # to do: customize this by the incoming url
    end
  end

  def edit
    all_instances
    @gift = Gift.find(params[:gift][:id])
    unless @gift.giver == @current_user
      flash[:danger] = 'You can only edit gifts that you are giving'
      redirect_to(@gift)
      # to do: customize this by the incoming url
    end
  end

  def update
    all_instances
    @gift = Gift.find(params[:gift][:id])
    if @gift.update(gift_params)
      flash[:success] = "Gift updated"
      redirect_to(@gift)
      # to do: customize this by the incoming url
    else
      flash[:danger] = "Gift update not saved"
      render 'edit_wish' # to do: customize this by the incoming url
    end
  end

  def destroy
   @gift = Gift.find(params[:gift][:id])
   if @gift.giver == @current_user
     if @gift.destroy
       flash[:success] = "Gift deleted"
     else
       flash[:danger] = "Gift not deleted"
     end
   else
     flash[:danger] = "You may only delete gifts that you are giving"
   end
   redirect_to(@current_user) # to do: customize this by the incoming url
 end

  def recieved
    @gift = Gift.find(params[:id])
    @gift.received = true
    if @gift.recipient == @current_user && @gift.save
      flash[:success] = "Gift marked as received"
    elsif @gift.recipient != @current_user
      flash[:failure] = "You can only mark gifts for you as received"
    else
      flash[:failure] = "Gift not marked as received"
    end
    redirect_to(@gift) # to do: customize this by the incoming url
  end

  private

    def all_instances
      @gifts = Gift.all
      @friends = Friend.all
      @wishes = Wish.all
    end

    def gift_params
      params.require(:gift).permit(:title, :description, :recipient, :asked_for, :intend_to_give, :giver, :shipped, :shipping_details, :recieved)
    end

end
