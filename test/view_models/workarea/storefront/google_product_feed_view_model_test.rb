require 'test_helper'

module Workarea
  module Storefront
    class GoogleProductFeedViewModelTest < TestCase
      def test_can_use_categories_from_rules
        create_category(google_name: 'Bar', product_ids: [product.id])

        assert_equal 'Bar', subject.category_name
      end

      def test_uses_default_category
        create_category(product_ids: [product.id], google_name: 'Apparel')

        assert_equal 'Apparel', subject.category_name
      end

      private

        def product
          @product ||= create_product(name: 'Foo')
        end

        def subject
          @subject ||= Storefront::GoogleProductFeedViewModel.new(product)
        end
    end
  end
end
