module Workarea
  module Storefront
    class GoogleProductFeedSkuViewModel < ApplicationViewModel
      module ProductImageUrl
        include Workarea::ApplicationHelper
        include Workarea::I18n::DefaultUrlOptions
        include ActionView::Helpers::AssetUrlHelper
        include Core::Engine.routes.url_helpers
        extend self

        def mounted_core
          self
        end
      end

      def status
        model.active? ? 'in stock' : 'out of stock'
      end

      def color
        Array.wrap(model.fetch_detail('color')).first
      end

      def condition
        'new'
      end

      def image_url
        return unless image.present?
        ProductImageUrl.product_image_url(image, GoogleProductFeed.image_size)
      end

      def size
        Array.wrap(model.fetch_detail('size')).first
      end

       def inventory
        inventory_sku? ? inventory_sku.available_to_sell : 0
      end

      def displayable?
        inventory_sku? ? inventory_sku.displayable? : false
      end

      def inventory_sku
        options[:inventory_sku]
      end

      def inventory_sku?
        options[:inventory_sku].present?
      end

      private

        def image
          @image ||= Storefront::ProductViewModel.wrap(product, sku: model.sku).primary_image
        end
    end
  end
end
