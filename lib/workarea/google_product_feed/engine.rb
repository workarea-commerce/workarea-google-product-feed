module Workarea
  module GoogleProductFeed
    class Engine < ::Rails::Engine
      include Workarea::Plugin
      isolate_namespace Workarea::GoogleProductFeed
    end
  end
end
