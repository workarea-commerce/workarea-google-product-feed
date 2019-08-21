module Workarea
  class Feed::Google
    class NoFeedError < StandardError; end

    include ApplicationDocument
    extend Dragonfly::Model

    field :feed_uid, type: String

    dragonfly_accessor :feed, app: :workarea

    def self.find_first_or_initialize
      first || new
    end
  end
end
