class Gift < ApplicationRecord
  belongs_to  :wish, optional: true
  belongs_to  :giver
  belongs_to  :recipient
end
