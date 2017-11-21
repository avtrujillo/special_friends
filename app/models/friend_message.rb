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
end
