require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ShareCars
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2

    config.assets.paths << Rails.root.join("vendor", "assets", "images")
    config.assets.precompile += %w[*.png *.jpg *.jpeg *.gif *.svg]

    config.action_mailer.default_url_options = { host: ENV["MAILER_HOST"] }
  end
end
