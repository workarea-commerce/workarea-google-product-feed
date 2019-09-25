Workarea Google Product Feed
================================================================================

Google Product Feed for the Workarea Platform

Google category
--------------------------------------------------------------------------------
The google product feed includes a field for google category. This field must map to one of the pre-defined categories.
Documentation can be found here [https://support.google.com/merchants/answer/6324436?hl=en](https://support.google.com/merchants/answer/6324436?hl=en)

The workarea platform implements this field by:
1) Look for google\_category on the product, use this if found.
2) Look for google\_name on the products default category
3) Look for google\_name on categories the product is in, use this if found
4) Use the default google category from Workarea::GoogleProductFeed.default\_category

Getting Started
--------------------------------------------------------------------------------

Add the gem to your application's Gemfile:

```ruby
# ...
gem 'workarea-google_product_feed'
# ...
```

Update your application's bundle.

```bash
cd path/to/application
bundle
```

Workarea Commerce Documentation
--------------------------------------------------------------------------------

See [https://developer.workarea.com](https://developer.workarea.com) for Workarea Commerce documentation.

License
--------------------------------------------------------------------------------

Workarea Google Product Feed is released under the [Business Software License](LICENSE)
