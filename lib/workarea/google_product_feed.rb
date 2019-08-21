require 'workarea'
require 'workarea/core'
require 'workarea/admin'
require 'workarea/storefront'

module Workarea
  module GoogleProductFeed
    def self.config
      Workarea.config.google_product_feed
    end

    # TODO remove next major
    def self.default_category=(default)
      config.default_category = default
    end

    def self.default_category
      config.default_category
    end

    def self.static_feed_values
      config.static_feed_values
    end

    def self.image_size
      config.image_size
    end
  end
end

require 'workarea/google_product_feed/version'
require 'workarea/google_product_feed/engine'
