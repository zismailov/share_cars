source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "2.5.0"

gem "activerecord-postgis-adapter"
gem "appsignal"
gem "bootsnap", ">= 1.1.0", require: false
gem "bootstrap-datepicker-rails"
gem "bootstrap-sass"
gem "coffee-rails", "~> 4.2"
# gem "elasticsearch-model"
# gem "elasticsearch-rails"
gem "daemons" # for running delayed jobs in development env
gem "delayed_job_active_record"
gem "geocoder"
gem "jbuilder", "~> 2.5"
gem "jquery-rails"
gem "jquery-turbolinks"
gem "jquery-ui-rails"
gem "kaminari"
gem "kaminari-bootstrap"
gem "mailjet"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 3.11"
gem "rails", "~> 5.2.0"
gem "sass-rails", "~> 5.0"
gem "simple_form"
gem "turbolinks", "~> 5"
gem "uglifier", ">= 1.3.0"

group :development, :test do
  gem "factory_bot_rails"
  gem "pry"
  gem "rspec-rails", "~> 3.7"
  gem "rubocop", require: false
  gem "rubocop-rspec", require: false
end

group :development do
  gem "letter_opener"
  gem "letter_opener_web"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15", "< 4.0"
  gem "selenium-webdriver"
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem "chromedriver-helper"
end
