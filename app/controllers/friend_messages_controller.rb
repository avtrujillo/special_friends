class FriendMessagesController < ApplicationController
  before_action :set_friend_message, only: [:show, :edit, :update, :destroy]

  # GET /friend_messages
  # GET /friend_messages.json
  def index
    @friend_messages = current_user.messages
  end

  def giver_index
    @friend_messages = FriendMessage.where(year: Time.christmas_year,
      friend_match_id: current_user.giver_match.id)
    @index_type = :giver
  end

  def recipient_index # NOT the same thing as recieved messages!
    @friend_messages = FriendMessage.where(year: Time.christmas_year,
      friend_match_id: current_user.recipient_match.id)
    @index_type = :recipient
  end

  def sender_name
    if sender == current_user
      'you'
    elsif sender == current_user.giver
      "your giver #{current_user.giver.name}"
    elsif sender == current_user.recipient
      "your recipient #{current_user.recipient.name}"
    else
      'do not read'
    end
  end

  def recipient_name
    if recipient == current_user
      'you'
    elsif recipient == current_user.giver
      "your giver #{current_user.giver.name}"
    elsif recipient == current_user.recipient
      "your recipient #{current_user.recipient.name}"
    else
      'do not read'
    end
  end

  # GET /friend_messages/1
  # GET /friend_messages/1.json
  def show
    @friend_message = FriendMessage.find_by(id: params[:id])
    unless [@friend_message.sender_id, @friend_message.recipient_id].include?(current_user.id)
      render status: 403, file: "#{Rails.root}/public/403.html" and return
    end
  end

  # GET /friend_messages/new
  def new_message_to_recipient
    @friend_message = FriendMessage.new(sender_id: current_user.id,
      recipient_id: current_user.recipient.id,
      recipient_match_id: current_user.recipient_match.id)
    render 'new'
  end

  def new_message_to_giver
    @friend_message = FriendMessage.new(sender_id: current_user.id,
      recipient_id: current_user.giver.id,
      friend_match_id: current_user.giver_match.id)
    render 'new'
  end

  # GET /friend_messages/1/edit
  def edit
    @friend_message = FriendMessage.find_by(id: params[:id])
    unless [@friend_message.sender_id, @friend_message.recipient_id].include?(current_user.id)
      render status: 403, file: "#{Rails.root}/public/403.html" and return
    end
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
