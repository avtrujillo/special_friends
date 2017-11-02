class Gift < ApplicationRecord
  belongs_to  :wish
  belongs_to  :giver
  belongs_to  :recipient

  def wish_name
    wish.name
  end

  def recipient_name
    recipient.name
  end
end
