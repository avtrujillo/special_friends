class Friend < ApplicationRecord

  has_many :recipient_matches, foreign_key: :recipient_id, class_name: 'FriendMatch', optional: true
  has_many :givers, through: :giver_matches, source: :giver, optional: true

  has_many :giver_matches, foreign_key: :giver_id, class_name: 'FriendMatch', optional: true
  has_many :recipients, through: :recipient_matches, source: :recipient, optional: true

  has_many  :recieved_gifts, foreign_key: :recipient_id, class_name: 'Gift', optional: true
  has_many  :given_gifts, foreign_key: :giver_id, class_name: 'Gift', optional: true

  belongs_to  :generation

  has_many  :forbidden_matches, optional: true

  def recipient
    recipients.find {|r| r.year == christmas_year}
  end

  def giver
    givers.find {|r| g.year == christmas_year}
  end

  def forbidden_match?(other_friend)
    ForbiddenMatch.where(
      friend_1: [self, other_friend], friend_2: [self, other_friend]
    ).exists?
  end
end
