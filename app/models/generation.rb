class Generation < ApplicationRecord
	has_many	:friends
	has_many	:matches, through: :friends, source: :giver_matches
end
