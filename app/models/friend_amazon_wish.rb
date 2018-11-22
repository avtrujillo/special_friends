class FriendAmazonWish < ApplicationRecord

  belongs_to :friend
  belongs_to :friend_amazon_list
  has_one :wish

  validates_uniqueness_of :external_id, scope: [:friend_id, :year]

  before_validation :set_year, on: [:create, :save]

  def set_year
    self.year = Time.christmas_year
  end

  def title
    self.wish.title if self.wish
  end

  def description
    self.wish.description if self.wish
  end

end
