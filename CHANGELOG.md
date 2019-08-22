Workarea Google Product Feed 3.1.4 (2019-08-22)
--------------------------------------------------------------------------------

*   Open Source! For real!



Workarea Google Product Feed 3.1.3 (2019-08-21)
--------------------------------------------------------------------------------

*   Open Source! lol jk



Workarea Google Product Feed 3.1.2 (2019-06-25)
--------------------------------------------------------------------------------

*   Update image urls in google product feed

    * change image size to be :detail so the images are larger than 250
    (googles requirement for apparel products)
    * fix problems with tests failing with multi-site

    GOOGPROD-22
    Eric Pigeon



Workarea Google Product Feed 3.1.1 (2018-09-19)
--------------------------------------------------------------------------------

*   Fix config values not being reset in tests

    Tests can fail because values aren't reset properly.

    GOOGPROD-20
    Ben Crouse



Google Product Feed 3.1.0 (2018-03-21)
--------------------------------------------------------------------------------

*   Add a configuration for static values in google merchant feed

    GOOGPROD-16
    Eric Pigeon

*   Use a product's default category first

    update the google taxonomy to prefer using it's default category first

    GOOGPROD-18
    Eric Pigeon


Google Product Feed 3.0.2 (2018-01-11)
--------------------------------------------------------------------------------

*   Product feed does not include inactive products

    GOOGPROD-10
    Jake Beresford

*   Improve implementation of Google category field

    * check product, then category, then fall back to a configuration

    GOOGPROD-11
    Jake Beresford

*   Do not export non-displayable skus to google feed

    GOOGPROD-10
    Jake Beresford


Google Product Feed 3.0.0 (2017-05-25)
--------------------------------------------------------------------------------

*   Fixes final test.

    GOOGPROD-7
    Beresford, Jake

*   Upgrade plugin for v3 compatibility

    * Rename
    * Convert rspec to minitest
    * Use Variant#active? instead of Variant#purchasable?

    GOOGPROD-7
    Beresford, Jake


Google Product Feed 2.0.5 (2016-12-07)
--------------------------------------------------------------------------------

*   Send the correct price for a variant

    If a product has different pricers per variant we should use the correct
    sell price for the sku rather than the minimal selling price of the
    product

    GOOGPROD-6
    Eric Pigeon
