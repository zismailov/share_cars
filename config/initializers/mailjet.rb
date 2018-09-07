Mailjet.configure do |config|
  config.api_key = ENV["MAILJET_API_KEY"]
  config.secret_key = ENV["MAILJET_API_SECRET"]
  config.default_from = "noreply@example.com"
end
