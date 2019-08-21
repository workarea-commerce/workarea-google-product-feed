Workarea Google Production Feed
================================================================================
Google Production Feed for the Workarea Platform


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

You must have access to a WebLinc gems server to use this gem. Add your gems server credentials to Bundler:

```bash
$ bundle config gems.weblinc.com my_username:my_password
```

Or set the appropriate environment variable in a shell startup file:

```bash
$ export BUNDLE_GEMS__WEBLINC__COM='my_username:my_password'
```

Then add the gem to your application's Gemfile specifying the source:

```ruby
# ...
gem 'workarea-google_product_feed', source: 'https://gems.weblinc.com'
# ...
```

Or use a source block:

```ruby
# ...
source 'https://gems.weblinc.com' do
  gem 'workarea-google_product_feed'
end
# ...
```

Update your application's bundle.

```bash
$ cd path/to/application ; bundle
```

Copyright & Licensing
--------------------------------------------------------------------------------

Copyright WebLinc 2018. All rights reserved.

For licensing, contact sales@workarea.com.
