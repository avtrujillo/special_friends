class Friend < ApplicationRecord
  has_many :givers, through: :giver_matches, source: :giver
  has_many :giver_matches, foreign_key: :recipient_id, class_name: 'FriendMatch'

  has_many :recipients, through: :recipient_matches, source: :recipient
  has_many :recipient_matches, foreign_key: :giver_id, class_name: 'FriendMatch'

  has_many  :recieved_gifts, foreign_key: :recipient_id, class_name: 'Gift'
  has_many  :given_gifts, foreign_key: :giver_id, class_name: 'Gift'

  belongs_to  :forbidden_match

  def forbidden_match?(other_friend)
    ForbiddenMatch.where(
      friend_1: [self, other_friend], friend_2: [self, other_friend]
    ).exists?
  end
end
