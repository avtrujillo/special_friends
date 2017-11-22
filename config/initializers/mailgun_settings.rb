Mailgun.configure do |config|
  config.api_key = Rails.application.secrets.private_mailgun_api
end
