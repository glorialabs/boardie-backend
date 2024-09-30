source "https://rubygems.org"

ruby "3.3.0"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.2"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"

# Use Redis adapter to run Action Cable in production
# gem "redis", ">= 4.0.1"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin Ajax possible
gem "rack-cors", "2.0.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem "capistrano-sidekiq", "2.3.1"
  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

gem "activeadmin", "3.2.2"
gem "devise", "4.9.4"
gem "sprockets-rails", "3.4.2"
gem "sass-rails", "6.0.0"
gem "active_model_serializers", "0.10.14"
gem "rest-client", "~> 2.1"
gem "interactor", "~> 3.1"
gem "open3", "0.2.1"

gem "capistrano", "~> 3.11"
gem "capistrano-rails", "~> 1.4"
gem "capistrano-passenger", "~> 0.2.0"
gem "capistrano-rbenv", "~> 2.1", ">= 2.1.4"
gem "rubocop-rails-omakase", require: false, group: [ :development ]
gem "exception_notification", "4.5.0"
gem "slack-notifier", "2.4.0"

gem "sidekiq", "~> 7.3"
gem "sidekiq-cron", "1.12"
gem "ed25519", ">= 1.2", "< 2.0"
gem "bcrypt_pbkdf", ">= 1.0", "<2.0"
