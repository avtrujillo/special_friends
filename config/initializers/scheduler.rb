require 'rufus-scheduler'

scheduler = Rufus::Scheduler.new

def christmas_year
  if Date.new.month < 6
    return Date.year - 1
  else
    return Date.year
  end
end

def generate_matches
  mh = generate_match_hash
  mh.each_pair do |recipient, giver|
    FriendMatch.create(
      giver_id: giver.id,
      recipient_id: recipient.id,
      year: christmas_year
    )
  end
end

def generate_match_hash
  Generation.all.map do |g|
    recipients = g.friends
    givers = recipients.dup
    recipients.each_with_object(Hash.new) do |r, h|
      h[r] = givers.delete(givers.sample)
    end
  end
end

def generate_valid_match_hash(matches_hash)
  loop do
    match_hash = generate_match_hash
    if match_hash.none? {|r, g| r.forbidden_match?(g)}
      return match_hash
    else
      redo
    end
  end
end

unless defined?(Rails::Console) || File.split($0).last == 'rake'
  scheduler.cron('00 12 L 9 *') do
    generate_matches
  end
end
