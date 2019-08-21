Workarea::Core::Engine.routes.draw do
  get 'google_feed' => Dragonfly.app(:workarea).endpoint { |params, app|
    raise Workarea::Feed::Google::NoFeedError if Workarea::Feed::Google.first.nil?
    app.fetch(Workarea::Feed::Google.first.feed_uid)
  }, as: :google_feed
end
