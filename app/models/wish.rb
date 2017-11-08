class Wish < ApplicationRecord
  has_many    :gifts
  belongs_to  :friend
end
