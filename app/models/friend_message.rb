class FriendMessage < ApplicationRecord
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'Friend'
  belongs_to :recipient, foreign_key: 'recipient_id', class_name: 'Friend'
  belongs_to :friend_match

  def match_giver
    friend_match.giver
  end

  def match_recipient
    friend_match.recipient
  end

  def sender_name
    if sender == current_user
      'you'
    elsif sender == current_user.giver
      "your giver"
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
      "your giver"
    elsif recipient == current_user.recipient
      "your recipient #{current_user.recipient.name}"
    else
      'do not read'
    end
  end
  
end
