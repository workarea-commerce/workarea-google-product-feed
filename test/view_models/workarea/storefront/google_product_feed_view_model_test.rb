require 'test_helper'

module Workarea
  module Storefront
    class GoogleProductFeedViewModelTest < TestCase
      setup :set_asset_host
      teardown :reset_asset_host

      def test_can_use_categories_from_rules
        create_category(google_name: 'Bar', product_ids: [product.id])

        assert_equal 'Bar', subject.category_name
      end

      def test_uses_default_category
        create_category(product_ids: [product.id], google_name: 'Apparel')

        assert_equal 'Apparel', subject.category_name
      end

      def test_image_uses_asset_host_if_supplied
        Workarea::Catalog::ProductPlaceholderImage.create
        assert_includes subject.image, 'www.assethost.com'
      end

      private

        def product
          @product ||= create_product(name: 'Foo')
        end

        def subject
          @subject ||= Storefront::GoogleProductFeedViewModel.new(product)
        end

        def set_asset_host
          @_asset_host = Rails.application.config.action_controller.asset_host
          Rails.application.config.action_controller.asset_host = 'http://www.assethost.com'
        end

        def reset_asset_host
          Rails.application.config.action_controller.asset_host = @_asset_host
        end
    end
  end
end
