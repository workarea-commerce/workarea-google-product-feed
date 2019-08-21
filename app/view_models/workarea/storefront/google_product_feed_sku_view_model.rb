module Workarea
  module Storefront
    class GoogleProductFeedSkuViewModel < ApplicationViewModel
      def status
        model.active? ? 'in stock' : 'out of stock'
      end

      def color
        Array.wrap(model.fetch_detail('color')).first
      end

      def condition
        'new'
      end

      def size
        Array.wrap(model.fetch_detail('size')).first
      end

      def displayable?
        return false unless options[:inventory_sku].present?
        options[:inventory_sku].displayable?
      end
    end
  end
end
