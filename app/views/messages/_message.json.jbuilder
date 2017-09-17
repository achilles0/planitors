json.extract! message, :id, :to_user_id, :from_user_id, :subject, :text, :sent_at, :read_at, :created_at, :updated_at
json.url message_url(message, format: :json)
