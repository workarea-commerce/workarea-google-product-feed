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

       def inventory
        inventory_sku? ? inventory_sku.available : 0
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
    end
  end
end
