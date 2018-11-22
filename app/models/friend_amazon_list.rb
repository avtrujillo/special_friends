class FriendAmazonList < ApplicationRecord

  belongs_to :friend
  has_many :friend_amazon_wishes

  before_validation :set_year, on: [:create, :save]

  validates_uniqueness_of :external_id, scope: [:friend_id, :year]

  def set_year
    self.year = Time.christmas_year
  end

  def wishes
    friend_amazon_wishes.map(&:wish)
  end

end
