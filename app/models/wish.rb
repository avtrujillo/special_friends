class Wish < ApplicationRecord
  has_many    :gifts
  belongs_to  :friend
  belongs_to  :friend_amazon_wish

  def fulfilled?
    Gift.where(wish_id: self.id, year: Time.christmas_year).any?
  end

  before_validation :set_year, on: [:create, :save]

  def set_year
    self.year = Time.christmas_year
  end
end
