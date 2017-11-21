class FriendMessage < ApplicationRecord
  belongs_to :sender, foreign_key: 'sender_id', class_name: 'Friend'
  belongs_to :recipient, foreign_key: 'recipient_id', class_name: 'Friend'
  belongs_to :friend_match
end
