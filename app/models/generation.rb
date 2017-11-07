class Generation < ApplicationRecord
	has_many	:friends
	has_many	:friend_matches, through: :friends, source: :giver_matches
end
