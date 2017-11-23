class GiftsController < ApplicationController

  def show
    @gift = Gift.find_by(id: params[:id])
    if @gift.nil?
      render status: 404, file: "#{Rails.root}/public/404.html" and return
    elsif @gift.recipient == @current_user # to do: make sure this works
      render status: 403, file: "#{Rails.root}/public/403.html" and return
      # to do: maybe have something other than an error here?
    end
  end

  def index
    if params[:friend_id].to_i == @current_user.id.to_i
      render status: 403, file: "#{Rails.root}/public/403.html" and return
      # to do: maybe have something other than an error here?
    elsif params[:friend_id]
      @friend = Friend.find_by(id: params[:friend_id])
      @wish = Wish.find_by(id: params[:wish_id])
      @receiving_gifts = Gift.where(recipient: @friend, year: Time.christmas_year).to_a.reject do |f|
        f.recipient_id == current_user.id
      end
      @giving_gifts = Gift.where(giver: @friend, year: Time.christmas_year).to_a.reject do |f|
        f.recipient_id == current_user.id
      end
      render 'friend_gifts' and return # to do: make this
    else
      @gifts = Gift.where(year: Time.christmas_year)
      render 'index' and return # to do: make this
    end
  end

  def new
    @gift = Gift.new
    @wish = Wish.find_by(id: params[:wish_id])
    @recipient = Friend.find_by(id: params[:friend_id])
    if @wish && @recipient && @wish.friend != @recipient
      render status: 404, file: "#{Rails.root}/public/404.html" and return
    end
    @giver = current_user
  end

  def create
    @gift = Gift.new(gift_params)
    if (@gift.recipient != current_user) && @gift.save
      flash[:success] = 'Gift saved'
      redirect_to Friend.find_by(id: @gift.recipient)
      # to do: customize this by the incoming url
    elsif @gift.recipient == current_user
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
    @gift = Gift.find(params[:gift_id])
    unless @gift.giver == current_user
      flash[:danger] = 'You can only edit gifts that you are giving'
      redirect_to(@gift)
      # to do: customize this by the incoming url
    end
  end

  def update
    @gift = Gift.find_by(id: params[:gift][:id])
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
    begin
      @gift = Gift.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render status: 404, file: "#{Rails.root}/public/404.html"
      return
    end
    if @gift.giver == current_user
     if @gift.destroy
       flash[:success] = "Gift deleted"
     else
       flash[:danger] = "Gift not deleted"
     end
   else
     flash[:danger] = "You may only delete gifts that you are giving"
   end
   redirect_to(current_user) # to do: customize this by the incoming url
  end

  def from_to
    if !(params[:giver_id] && params[:recipient_id])
      render status: 404, file: "#{Rails.root}/public/404.html" and return
    elsif params[:recipient_id].to_i == current_user.id.to_i
      render status: 403, file: "#{Rails.root}/public/403.html" and return
    else
      @giver = Friend.find_by(id: params[:giver_id])
      @recipient_id = Friend.find_by(id: params[:recipient_id])
      render 'index' and return
    end
  end

  private

    def gift_params
      params.require(:gift).permit(:title, :description, :wish_id, :year,
        :recipient_id, :purchase_status, :giver_id)
    end

end
