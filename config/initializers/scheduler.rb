require 'rufus-scheduler'
include FriendsHelper

scheduler = Rufus::Scheduler.new

unless defined?(Rails::Console) || File.split($0).last == 'rake'
  scheduler.cron('00 12 L 9 *') do
    generate_matches
  end
end
