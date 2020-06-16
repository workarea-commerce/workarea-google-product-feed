module Workarea
  module Storefront
    class GoogleProductFeedViewModel < ApplicationViewModel
      include ActionView::Helpers::SanitizeHelper
      include ActionView::Helpers::TextHelper

      def self.fields
        [
          'item_group_id',
          'id',
          'title',
          'description',
          'link',
          'image_link',
          'availability',
          'inventory',
          'condition',
          'brand',
          'color',
          'size',
          'google_product_category',
          'product_type',
          'price'
        ] + GoogleProductFeed.static_feed_values.keys
      end

      delegate :sell_min_price, to: :pricing

      def brand
        return '' unless model.filters['brand'].present?
        model.filters['brand'].join(' ')
      end

      def category_name
        model.google_category.presence ||
        category&.google_name.presence ||
        Workarea::GoogleProductFeed.default_category
      end

      def meta_description
        if model.meta_description.present?
          sanitize_description(model.meta_description)
        else
          sanitize_description(model.description)
        end
      end

      def product_type
        return '' unless model.filters['product_type'].present?
        model.filters['product_type'].first
      end

      def variants
        @variants ||= model.variants.map do |variant|
          GoogleProductFeedSkuViewModel.wrap(
            variant,
            inventory_sku: inventory.for_sku(variant.sku)
          )
        end
      end

      def sku_price(sku)
        pricing.for_sku(sku).sell
      end

      private

        def category
          return categorization.default_model if categorization.default_model&.google_name.present?

          categorization.to_models.detect { |c| c.google_name.present? } ||
            categorization.to_models.first
        end

        def categorization
          @categorization ||= Workarea::Categorization.new(model)
        end

        def inventory
          @inventory ||= Inventory::Collection.new(model.variants.map(&:sku))
        end

        def pricing
          @pricing ||= Pricing::Collection.new(model.variants.map(&:sku))
        end

        def sanitize_description(description)
          return if description.nil?

          # strip html and shorten to the google max of 5k chars
          sanitized = truncate(strip_tags(description), length: 5000)

          # strip tabs and new lines
          sanitized.tr("\t\r\n", '')
        end
    end
  end
end
