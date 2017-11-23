class FriendMessagesController < ApplicationController
  before_action :set_friend_message, only: [:show, :edit, :update, :destroy]

  # GET /friend_messages
  # GET /friend_messages.json
  def index
    @friend_messages = current_user.messages.to_a.sort_by(&:created_at).reverse
    @index_type = nil
    mark_messages_as_read(@friend_messages)
  end

  def messages_as_giver
    @friend_messages = current_user.giver_match.messages
    @friend_messages.sort_by!(&:created_at).reverse!
    @index_type = :as_giver
    @giver = 'you'
    @recipient = "your recipient #{current_user.recipient.name}"
    render 'index'
    mark_messages_as_read(@friend_messages)
  end

  def messages_as_recipient # NOT the same thing as recieved messages!
    @friend_messages = current_user.recipient_match.messages
    @friend_messages.sort_by!(&:created_at).reverse!
    @index_type = :as_recipient
    render 'index'
    @giver = 'your giver'
    @recipient = 'you'
    mark_messages_as_read(@friend_messages)
  end

  def unread
    @friend_messages = FriendMessage.where(recipient_id: current_user.id, read?: false).to_a
    @friend_messages.sort_by!(&:created_at).reverse!
    @index_type = :unread
    mark_messages_as_read(@friend_messages)
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
    @sending_to = :recipient
    @friend_message = FriendMessage.new(sender_id: current_user.id,
      recipient_id: current_user.recipient.id,
      friend_match_id: current_user.giver_match.id)
    render 'new'
  end

  def new_message_to_giver
    @sending_to = :giver
    @friend_message = FriendMessage.new(sender_id: current_user.id,
      recipient_id: current_user.giver.id,
      friend_match_id: current_user.recipient_match.id)
    render 'new'
  end

  # POST /friend_messages
  # POST /friend_messages.json
  def create
    @friend_message = FriendMessage.new(friend_message_params)

    respond_to do |format|
      if @friend_message.save
        FriendMailer.fm_notification(@friend_message)
        format.html { redirect_to @friend_message, notice: 'Friend message was successfully created.' }
        format.json { render :show, status: :created, location: @friend_message }
      else
        format.html { render :new }
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

    def mark_messages_as_read(messages)
      messages.each { |m| m.update_attribute(:read?, true) }
    end
end
