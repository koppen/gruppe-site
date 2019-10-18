# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module GruppeSite
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults "6.0"

    # Settings in config/environments/* take precedence over those specified
    # here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # By opting-out from `add_autoload_paths_to_load_path` you optimize
    # $LOAD_PATH lookups (less directories to check), and save Bootsnap work and
    # memory consumption, since it does not need to build an index for these
    # directories.
    config.add_autoload_paths_to_load_path = false
  end
end
