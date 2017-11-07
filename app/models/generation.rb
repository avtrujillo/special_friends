class Generation < ApplicationRecord
	has_many	:friends, optional: true
	has_many	:friend_matches, through: :friends, source: :giver_matches, optional: true
end
