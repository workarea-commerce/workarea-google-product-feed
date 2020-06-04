require 'test_helper'

module Workarea
  class Exporting::GoogleFeedTest < TestCase
    setup :set_asset_host
    teardown :reset_asset_host

    def test_first_row_is_header
      assert_equal(rows.first, [
        'item_group_id', 'id', 'title', 'description',
        'link', 'image_link', 'availability', 'inventory',
        'condition', 'brand', 'color', 'size',
        'google_product_category', 'product_type', 'price'
      ])
    end

    def product
      @product ||= create_product(
        id: 'PROD', name: 'Test Product',
        description: '<p>Paragraph test</p>',
        filters: { brand: ['Workarea'], product_type: ['Test'] },
        variants: [
          { sku: 'SKU', regular: 1.to_m, details: { color: 'Red', size: 'Large' } },
          { sku: 'SKU2', regular: 2.to_m, details: { color: 'Blue', size: 'Small' } }
        ]
      )
      @product.images.build
      @product.save!
      @product
    end

    def test_second_row_is_product
      Workarea.with_config do |config|
        config.domain = 'www.client.com'
        create_category(
          name: 'Test Category',
          google_name: 'Google Category',
          product_ids: [product.id]
        )

        rows.second.tap do |row|
          assert_equal('PROD', row[0])
          assert_equal('SKU', row[1])
          assert_equal('Test Product', row[2])
          assert_equal('Paragraph test', row[3])
          assert_equal('http://www.example.com/products/test-product?sku=' + product.skus.first.to_s, row[4])
          assert_equal("http://www.assethost.com/product_images/test-product/#{product.images.first.id}/detail.jpg?c=0", row[5])
          assert_equal('in stock', row[6])
          assert_equal('99999', row[7])
          assert_equal('new', row[8])
          assert_equal('Workarea', row[9])
          assert_equal('Red', row[10])
          assert_equal('Large', row[11])
          assert_equal('Google Category', row[12])
          assert_equal('Test', row[13])
          assert_equal(1.to_m.to_s, row[14])
        end

        rows.third.tap do |row|
          assert_equal('PROD', row[0])
          assert_equal('SKU2', row[1])
          assert_equal('Test Product', row[2])
          assert_equal('Paragraph test', row[3])
          assert_equal('http://www.example.com/products/test-product?sku=' + product.skus.second.to_s, row[4])
          assert_equal("http://www.assethost.com/product_images/test-product/#{product.images.first.id}/detail.jpg?c=0", row[5])
          assert_equal('in stock', row[6])
          assert_equal('99999', row[7])
          assert_equal('new', row[8])
          assert_equal('Workarea', row[9])
          assert_equal('Blue', row[10])
          assert_equal('Small', row[11])
          assert_equal('Google Category', row[12])
          assert_equal('Test', row[13])
          assert_equal(2.to_m.to_s, row[14])
        end
      end
    end

    def test_google_category_uses_product_google_category_if_present
      product.google_category = 'Product Google Category'

      create_category(
        name: 'Test Category 1',
        google_name: 'Google Category',
        product_ids: [product.id]
      )

      assert_equal('Product Google Category', rows.second[12])
    end

    def test_uses_second_category_if_first_category_does_not_have_a_google_name
      create_category(
        name: 'Test Category 1',
        product_ids: [product.id]
      )
      create_category(
        name: 'Test Category 2',
        google_name: 'Google Category',
        product_ids: [product.id]
      )

      assert_equal('Google Category', rows.second[12])
    end

    def test_uses_default_category_name_if_google_name_is_blank
      Workarea.with_config do |config|
        config.google_product_feed.default_category = 'Apparel & Accessories'

        create_category(
          name: 'Test Category',
          product_ids: [product.id]
        )

        assert_equal('Apparel & Accessories', rows.second[12])
      end
    end

    def test_does_not_export_non_displayable_skus
      create_category(
        name: 'Test Category',
        google_name: 'Google Category',
        product_ids: [product.id]
      )

      create_inventory(id: product.variants.first.sku, available: 0)

      rows.second.tap do |row|
        refute_equal(product.variants.first.sku, row[1])
        assert_equal(product.variants.second.sku, row[1])
      end

      assert(rows.third.nil?)
    end

    def test_export_skus_inventory_with_inventory_skus
      create_category(
        name: 'Test Category',
        google_name: 'Google Category',
        product_ids: [product.id]
      )

      create_inventory(id: product.variants.first.sku, available: 1)
      create_inventory(id: product.variants.second.sku, available: 2)

      assert_equal('1', rows.second[7])
      assert_equal('2', rows.third[7])
    end

    def test_export_skus_inventory_with_no_inventory_skus
      create_category(
        name: 'Test Category',
        google_name: 'Google Category',
        product_ids: [product.id]
      )

      assert_equal('99999', rows.second[7])
    end

    def test_does_not_export_inactive_products
      create_category(
        name: 'Test Category',
        google_name: 'Google Category',
        product_ids: [product.id]
      )

      create_inventory(id: product.variants.first.sku)

      product.update_attributes!(active: false)

      assert(rows.second.nil?)
    end

    def test_static_columns
      Workarea.with_config do |config|
        config.google_product_feed.static_feed_values = { age_group: 'infant' }
        product

        assert_equal 'age_group', rows.first.last
        assert_equal 'infant', rows.second.last
      end
    end

    private

    def set_asset_host
      @_asset_host = Rails.application.config.action_controller.asset_host
      Rails.application.config.action_controller.asset_host = 'http://www.assethost.com'
    end

    def reset_asset_host
      Rails.application.config.action_controller.asset_host = @_asset_host
    end

    def google_feed
      @google_feed ||= Exporting::GoogleFeed.new
    end

    def filename
      @filename ||= Workarea::Exporting::GoogleFeed.temp_file
    end

    def rows
      google_feed.generate_csv
      File.open(filename).read.split("\n").map { |line| line.split("\t") }
    end
  end
end
