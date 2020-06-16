require 'test_helper'

module Workarea
  module Storefront
    class GoogleProductFeedSkuViewModelTest < TestCase
      def test_image_uses_asset_host_if_supplied
        asset_host = Rails.application.config.action_controller.asset_host
        Rails.application.config.action_controller.asset_host = 'http://www.assethost.com'

        product = create_product
        view_model = Storefront::GoogleProductFeedSkuViewModel.new(product.variants.first)
        assert_includes(view_model.image_url, 'www.assethost.com')

      ensure
        Rails.application.config.action_controller.asset_host = asset_host
      end
    end
  end
end
