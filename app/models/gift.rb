class Gift < ApplicationRecord
  belongs_to  :wish, optional: true
  belongs_to  :giver, class_name: 'Friend'
  belongs_to  :recipient, class_name: 'Friend'
  validates_associated  :giver
  validates_associated  :recipient
  validate :valid_purchase_status
  before_validation :set_year, on: [:create, :save]

  def set_year
    self.year = Time.christmas_year
  end

  def valid_purchase_status
    unless ["purchased", "intend", 'sent'].include?(purchase_status)
      errors.add(:purchase_status, "can only be be 'purchased', 'intend', or 'sent'")
    end
  end
end
