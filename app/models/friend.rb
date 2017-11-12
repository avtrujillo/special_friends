class Friend < ApplicationRecord

  has_many :giver_matches, foreign_key: :giver_id, class_name: 'FriendMatch'
  has_many :recipient_matches, foreign_key: :recipient_id, class_name: 'FriendMatch'
  has_many :givers, through: :giver_matches, source: :giver
  has_many :recipients, through: :recipient_matches, source: :recipient

  has_many  :recieved_gifts, foreign_key: :recipient_id, class_name: 'Gift'
  has_many  :given_gifts, foreign_key: :giver_id, class_name: 'Gift'
  has_many  :wishes
  has_many  :intend_to_fulfill, foreign_key: :intend_to_fulfill_id, class_name: 'Wish'

  belongs_to  :generation

  def forbidden_matches
    ForbiddenMatch.where("friend_1_id = ? OR friend_2_id = ?", self.id, self.id)
  end

  def giver_match # the match from this year in which this friend is the giver
    giver_matches.find {|gm| gm.year == christmas_year}
  end

  def recipient_match # the match from this year in which this friend is the
    recipient_matches.find {|rm| rm.year == christmas_year} # => recipient
  end

  def giver # the person that this friend is giving too this year
    recipient_match.giver if giver_match
  end

  def recipient # the person that this friend is recieving from this year
    giver_match.recipient if giver_match
  end

  def gifts_from(other_friend)
    Gift.where(recipient: self, giver: other_friend)
  end



  def forbidden_match?(other_friend)
    return true if other_friend == self
    ForbiddenMatch.where(
      friend_1: [self, other_friend], friend_2: [self, other_friend]
    ).exists?
  end
end
