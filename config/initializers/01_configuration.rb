Workarea.configure do |config|
  config.google_product_feed = ActiveSupport::Configurable::Configuration.new

  config.google_product_feed.static_feed_values = {}

  config.google_product_feed.image_size = :detail
end
