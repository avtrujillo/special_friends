class FriendMessagesController < ApplicationController
  before_action :set_friend_message, only: [:show, :edit, :update, :destroy]

  # GET /friend_messages
  # GET /friend_messages.json
  def index
    @friend_messages = current_user.messages
  end

  def giver_messages
    @friend_messages = FriendMessage.where(year: Time.christmas_year,
      friend_match_id: current_user.giver_match.id)
  end

  def recipient_messages # NOT the same thing as recieved messages!
    @friend_messages = FriendMessage.where(year: Time.christmas_year,
      friend_match_id: current_user.recipient_match.id)
  end

  # GET /friend_messages/1
  # GET /friend_messages/1.json
  def show
    @friend_message = FriendMessage.find_by(id: params[:id])
  end

  # GET /friend_messages/new
  def new
    @friend_message = FriendMessage.new
  end

  # GET /friend_messages/1/edit
  def edit
    @friend_message = FriendMessage.find_by(id: params[:id])
  end

  # POST /friend_messages
  # POST /friend_messages.json
  def create
    @friend_message = FriendMessage.new(friend_message_params)

    respond_to do |format|
      if @friend_message.save
        format.html { redirect_to @friend_message, notice: 'Friend message was successfully created.' }
        format.json { render :show, status: :created, location: @friend_message }
      else
        format.html { render :new }
        format.json { render json: @friend_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /friend_messages/1
  # PATCH/PUT /friend_messages/1.json
  def update
    respond_to do |format|
      if @friend_message.update(friend_message_params)
        format.html { redirect_to @friend_message, notice: 'Friend message was successfully updated.' }
        format.json { render :show, status: :ok, location: @friend_message }
      else
        format.html { render :edit }
        format.json { render json: @friend_message.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friend_messages/1
  # DELETE /friend_messages/1.json
  def destroy
    @friend_message.destroy
    respond_to do |format|
      format.html { redirect_to friend_messages_url, notice: 'Friend message was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_friend_message
      @friend_message = FriendMessage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def friend_message_params
      params.require(:friend_message).permit(:friend_match_id, :sender_id, :recipient_id, :content)
    end
end
