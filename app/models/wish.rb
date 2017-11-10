class Wish < ApplicationRecord
  has_many    :gifts
  belongs_to  :friend
  belongs_to   :intend_to_fulfill, class_name: 'Friend'

  def fulfilled?
    Gift.where(wish_id: self.id, year: christmas_year).any?
  end

  before_validation :set_year, on: [:create, :save]

  def set_year
    self.year = Time.christmas_year
  end
end
