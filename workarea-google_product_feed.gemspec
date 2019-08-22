$:.push File.expand_path('../lib', __FILE__)

require 'workarea/google_product_feed/version'

Gem::Specification.new do |s|
  s.name        = 'workarea-google_product_feed'
  s.version     = Workarea::GoogleProductFeed::VERSION
  s.authors     = ['Curt Howard']
  s.email       = ['choward@workarea.com']
  s.homepage    = 'https://github.com/workarea-commerce/workarea-google_product_feed'
  s.summary     = 'Google Product Feed for the Workarea commerce platform'
  s.description = 'Google Product Feed Rails Engine of the Workarea commerce platform'
  s.files       = `git ls-files`.split("\n")
  s.license = 'Business Software License'

  s.add_dependency 'workarea', '~> 3.x', '>= 3.2'
end
