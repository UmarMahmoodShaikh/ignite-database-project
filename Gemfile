source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.3", ">= 7.0.3.1"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"

# Use Redis adapter to run Action Cable in production
gem 'redis'
gem 'hiredis'

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# gem "bcrypt", "~> 3.1.7"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Use Sass to process CSS
# gem "sassc-rails"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

# group :test do
#   # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
#   gem "capybara"
#   gem "selenium-webdriver"
#   gem "webdrivers"
# end

group :development, :test do
gem 'rspec-rails'
end
group :test do
gem 'shoulda-matchers'
gem 'rspec-activemodel-mocks'
gem 'rspec-its'
end

gem 'grape'
gem 'grape-entity'
gem 'faker'
gem 'grape_on_rails_routes'

gem 'elasticsearch-model'
gem 'elasticsearch-rails'

gem "google-cloud-storage", "~> 1.38"
gem 'excon'

gem "ruby-kafka", '~> 1.5.0'
gem "kafka"
gem 'digest-murmurhash'


gem 'devise'

gem 'sidekiq'
group :development do
 gem 'capistrano-sidekiq'
end

gem "httparty", "~> 0.20.0"


 gem 'letter_opener'

 gem "algoliasearch-rails"

gem "ignite-client"

gem 'openssl'


gem 'faker'
gem "rubocop-faker", "~> 1.1"

