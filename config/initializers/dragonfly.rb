require "dragonfly"

# Configure
Dragonfly.app.configure do
  plugin :imagemagick

  secret "053b926a0c5f0d0189c31c2734ec914ac37822b9b749deb9c1c7046e0b032cc4"

  url_format "/media/:job/:name"

  datastore :file,
    root_path: Rails.root.join("public/system/dragonfly", Rails.env),
    server_root: Rails.root.join("public")
end

# Logger
Dragonfly.logger = Rails.logger

# Mount as middleware
Rails.application.middleware.use Dragonfly::Middleware

# Add model functionality
ActiveSupport.on_load(:active_record) do
  extend Dragonfly::Model
  extend Dragonfly::Model::Validations
end

# if defined?(ActiveRecord::Base)
#   ActiveRecord::Base.extend Dragonfly::Model
#   ActiveRecord::Base.extend Dragonfly::Model::Validations
# end
