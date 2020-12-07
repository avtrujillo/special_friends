class FriendMatch < ApplicationRecord
  belongs_to :giver, foreign_key: "giver_id", class_name: "Friend"
  belongs_to :recipient, foreign_key: "recipient_id", class_name: "Friend"
  has_many :messages, foreign_key: 'friend_match_id', class_name: 'FriendMessage'
  #validates_uniqueness_of :giver_id
  #validates_uniqueness_of :recipient_id
  validates_associated  :giver
  validates_associated  :recipient

  def generation
    giver.generation
  end

  def self.generate_generation_matches(gen_id)
    generate_valid_matches_hash.tap do |mh|
      mh.each_pair do |recipient, giver|
        if giver.generation.id == gen_id
            FriendMatch.create!(
            giver_id: giver.id,
            recipient_id: recipient.id,
            year: Time.christmas_year
          )
        end
      end
    end
  end

  def gifts
    Gift.where giver: self.giver, recipient: self.recipient, year: self.year
  end

  def self.generate_friend_matches
    mh = generate_valid_matches_hash
    mh.each_pair do |recipient, giver|
      FriendMatch.create!(
        giver_id: giver.id,
        recipient_id: recipient.id,
        year: Time.christmas_year
      )
    end
  end

  protected

  def self.generate_matches_hash
    matches_hash = Generation.all.each_with_object(Hash.new) do |gen, h|
      recipients = gen.friends.to_a
      givers = recipients.dup
      recipients.each do |recipient|
        h[recipient] = givers.delete(givers.sample)
      end
    end
  end

  def self.generate_valid_matches_hash
    loop do
      matches_hash = generate_matches_hash
      if matches_hash.none? {|r, g| r.forbidden_match?(g) || r == g}
        return matches_hash
      else
        redo
      end
    end
  end

  def self.transfer_friend_match(friend_id)
    giver_id = FriendMatch.find_by(recipient_id: friend_id).giver_id
    recipient_id = FriendMatch.find_by(giver_id: friend_id).recipient_id
    FriendMatch.create!(giver_id: giver_id, recipient_id: recipient_id, year: Time.christmas_year)
  end

end
