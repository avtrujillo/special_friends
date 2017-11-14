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
    if params[:friend] && params[:friend][:id] == @current_user.id
      render status: 403, file: "#{Rails.root}/public/403.html" and return
      # to do: maybe have something other than an error here?
    elsif params[:friend]
      @friend = Friend.find_by(id: params[:friend][:id])
      @wish = Wish.find_by(id: params[:wish][:id])
      @receiving_gifts = Gift.where(recipient: @friend, year: Time.christmas_year).reject do |f|
        f.recipient_id == @current_user.id
      end
      @giving_gifts = Gift.where(giver: @friend, year: Time.christmas_year).reject do |f|
        f.recipient_id == @current_user.id
      end
      render 'friend_gifts' and return # to do: make this
    else
      @gifts = Gift.where(year: Time.christmas_year)
      render 'index' and return # to do: make this
    end
  end

  def new
    @gift = Gift.new
    @wish = Wish.find(params[:wish][:id]) if params[:wish]
    @recipient = Friend.find(params[:friend][:id]) if params[:friend]
    @giver = @current_user
  end

  def create
    @gift = Gift.new(gift_params)
    if (@gift.recipient != @current_user) && @gift.save
      flash[:success] = 'Gift saved'
      redirect_to Friend.find_by(id: @gift.recipient)
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
    @gift = Gift.find(params[:gift][:id])
    unless @gift.giver == @current_user
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
      render status: 404, file: File.join(Rails.root, 'public', '404.html')
      return
    end
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

  def received
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

    def gift_params
      params.require(:gift).permit(:title, :description, :wish_id,
        :recipient_id, :purchase_status, :giver_id)
    end

end
