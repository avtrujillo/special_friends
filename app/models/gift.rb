class Gift < ApplicationRecord
  def wish_name
    wish.name
  end
  def recipient_name
    recipient.name
  end
end
