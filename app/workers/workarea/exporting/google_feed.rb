module Workarea
  module Exporting
    class GoogleFeed
      include Sidekiq::Worker
      include I18n::DefaultUrlOptions
      include Storefront::Engine.routes.url_helpers

      cattr_accessor :execution_block_size, :temp_file
      self.execution_block_size = 100
      self.temp_file = 'tmp/export/google_feed.txt'

      sidekiq_options queue: 'low'

      def perform(*args)
        generate_csv
        save_google_feed
      end

      def generate_csv
        ensure_directory

        @feed = CSV.open(GoogleFeed.temp_file, 'w', col_sep: "\t")
        write_header
        write_google_feed

      ensure
        @feed.close if defined?(@feed)
      end

      private

      def ensure_directory
        directory = File.dirname(GoogleFeed.temp_file)
        FileUtils.mkdir_p(directory)
      end

      def write_header
        @feed << Storefront::GoogleProductFeedViewModel.fields
      end

      def write_google_feed
        Catalog::Product.all.each_by(GoogleFeed.execution_block_size) do |p|
          product = Storefront::GoogleProductFeedViewModel.wrap(p)

          product.variants.each do |sku|
            next unless item_valid(product, sku)
            @feed << values_array(product, sku)
          end
        end
      end

      def save_google_feed
        google_feed = Feed::Google.find_first_or_initialize
        google_feed.feed = @feed
        google_feed.save!
      end

      def host
        Workarea.config.host
      end

      def item_valid(product, sku)
        sku.active? &&
          sku.displayable? &&
          product.active? &&
          product.sku_price(sku.sku).present? &&
          product.sku_price(sku.sku).positive?
      end

      def values_array(product, sku)
        [
          product.id,
          sku.sku,
          product.name,
          product.meta_description,
          product_url(product, host: host, sku: sku.sku),
          product.image,
          sku.status,
          sku.inventory,
          sku.condition,
          product.brand,
          sku.color,
          sku.size,
          product.category_name,
          product.product_type,
          product.sku_price(sku.sku)
        ] + GoogleProductFeed.static_feed_values.values
      end
    end
  end
end
