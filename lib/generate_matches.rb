include FriendsHelper # this contains the christmas_year method, at least for now

def generate_matches
  mh = generate_valid_matches_hash
  mh.each_pair do |recipient, giver|
    FriendMatch.create(
      giver_id: giver.id,
      recipient_id: recipient.id,
      year: christmas_year
    )
  end
end

def generate_matches_hash
  matches_hash = Generation.all.each_with_object(Hash.new) do |gen, h|
    recipients = gen.friends.to_a
    givers = recipients.dup
    recipients.each do |recipient|
      h[recipient] = givers.delete(givers.sample)
    end
  end
end

def generate_valid_matches_hash
  loop do
    matches_hash = generate_matches_hash
    if matches_hash.none? {|r, g| r.forbidden_match?(g) || r == g}
      return matches_hash
    else
      redo
    end
  end
end
