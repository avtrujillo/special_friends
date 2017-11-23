class WishesController < ApplicationController
  include ActionController::MimeResponds
  respond_to :html, :json

  def new
    @wish = Wish.new(friend_id: current_user.id, year: Time.christmas_year)
  end

  def create
    @wish = Wish.new(wish_params)
    if @wish.save!
      flash[:success] = 'Wish created successfully'
      redirect_to wishes_friend_path(current_user)
    else
      flash[:failure] = 'Something went wrong and the wish was not created successfully'
      redirect_to 'new'
    end
  end

  def edit
    @wish = Wish.find_by(id: params[:id])
    unless @wish.friend == current_user
      render status: 403, file: "#{Rails.root}/public/403.html" and return
    end
  end

  def update
    @wish = Wish.find_by(id: params[:id])
    if @wish.update_attributes!(wish_params)
      flash[:success] = 'Wish created successfully'
      redirect_to @wish
    else
      flash[:failure] = 'Something went wrong and the wish was not edited successfully'
      redirect_to 'new'
    end
   end

  def show
    @wish = Wish.find_by(id: params[:id])
  end

  def unfulfilled
    byebug
    @wishes = Wish.where(year: Time.christmas_year).to_a
    @wishes.reject! { |wish| wish.fulfilled? || wish.friend_id == current_user.id }
    @index_type = :unfulfilled
    render 'index'
  end

  def all
    @wishes = Wish.where(year: Time.christmas_year).to_a
    @index_type = :all
    render 'index'
  end

  def friend_unfulfilled
    if params[:friend_id].to_i == current_user.id
      redirect_to all_wishes_friend_path(current_user)
    end
    @friend = Friend.find_by(id: params[:friend_id])
    @wishes = Wish.where(friend_id: params[:friend_id], year: Time.christmas_year).to_a
    @wishes.reject! { |wish| wish.fulfilled? }
    @index_type = :unfulfilled
    render 'index'
  end

  def friend_all
    @friend = Friend.find_by(friend_id: params[:friend_id])
    @wishes = Wish.where(friend_id: params[:friend_id], year: Time.christmas_year).to_a
    @index_type = :all
    render 'index'
  end

  def destroy
    @wish = Wish.find_by(id: params[:id])
    if @wish && @wish.friend == current_user
      if @wish.destroy!
       flash[:success] = "Wish deleted"
      else
        flash[:danger] = "Wish not deleted, something went wrong"
      end
    else
      flash[:danger] = "You may only delete wishes that are yours"
    end
    redirect_to wishes_friend_path(current_user) # to do: customize this by the incoming url
  end

  def friend_wishes_ajax
    friend_id = params[:id]
    @friend_wishes = Wish.where(year: Time.christmas_year, friend_id: friend_id)
    respond_to do |format|
      format.json { render json: @friend_wishes.to_json }
    end
  end

  private

  def wish_params
    params.require(:wish).permit(:title, :description, :friend_id, :year)
  end

end
