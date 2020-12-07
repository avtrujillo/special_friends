class Generation < ApplicationRecord
	has_many	:friends
	has_many	:friend_matches, through: :friends, source: :giver_matches

	def create_matches
		FriendMatch.generate_generation_matches(self.id)
	end
end
