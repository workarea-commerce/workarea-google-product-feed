require_relative 'boot'

require "action_controller/railtie"
require "action_view/railtie"
require "action_mailer/railtie"
require "rails/test_unit/railtie"
require 'workarea'
require 'teaspoon-mocha'


Bundler.require(*Rails.groups)
require "workarea/google_product_feed"

module Dummy
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
