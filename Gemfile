# frozen_string_literal: true

source "https://rubygems.org"

ruby "2.6.5"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

gem "rails"

gem "bootsnap", ">= 1.4.2", :require => false

# Database
gem "postgresql"

# App serving
gem "puma"

gem "rails-i18n"

# Authentication
gem "devise"

# Frontend
gem "simple_form"
gem "slim-rails"
gem "turbolinks"
gem "webpacker"

# Assets management
gem "uglifier"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger
  # console
  gem "byebug", :platforms => [:mri, :mingw, :x64_mingw]
  # Adds support for Capybara system testing and selenium driver
  gem "capybara"
  gem "selenium-webdriver"

  gem "dotenv-rails"

  gem "factory_bot_rails"
  gem "rspec-rails", ">= 4.0.0.beta2"
  gem "shoulda-matchers"

  gem "rubocop"
  gem "rubocop-performance"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere
  # in the code.
  gem "listen"
  gem "web-console", "<= 4.0.1"

  # Run stuff automatically
  gem "guard"
  gem "guard-livereload"
  gem "guard-rspec"
  gem "guard-rubocop"

  # Spring speeds up development by keeping your application running in the
  # background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "spring-watcher-listen"
end

group :test do
  gem "database_cleaner", :require => false
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", :platforms => [:mingw, :mswin, :x64_mingw, :jruby]
