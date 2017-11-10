class Gift < ApplicationRecord
  belongs_to  :wish, optional: true
  belongs_to  :giver, class_name: 'Friend'
  belongs_to  :recipient, class_name: 'Friend'
  validates_associated  :giver
  validates_associated  :recipient
  before_validation :set_year, on: [:create, :save]

  def set_year
    self.year = Time.christmas_year
  end
end
