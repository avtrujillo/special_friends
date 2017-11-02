class FriendMatch < ApplicationRecord
  belongs_to :giver, foreign_key: "giver_id", class_name: "Friend"
  belongs_to :recipient, foreign_key: "recipient_id", class_name: "Friend"

  def generation
    giver.generation
  end

  def gifts
    Gift.where giver: self.giver, recipient: self.recipient, year: self.year
  end

end
