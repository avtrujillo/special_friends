json.extract! friend_message, :id, :friend_match_id, :sender_id, :recipient_id, :content, :created_at, :updated_at
json.url friend_message_url(friend_message, format: :json)
