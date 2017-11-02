class ForbiddenMatch < ApplicationRecord
	belongs_to	:friend_1, class_name: 'Friend'
	belongs_to	:friend_2, class_name: 'Friend'
end
