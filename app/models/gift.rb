class Gift < ApplicationRecord
  belongs_to  :wish, optional: true
  belongs_to  :giver, class_name: 'Friend'
  belongs_to  :recipient, class_name: 'Friend'
end
