module Autobot
  module Jobs
    class Base < ::Jobs::Base

      def execute(args)
        @campaign = Autobot::Campaign.find(args[:campaign_id])

        poll(@campaign)
      end

      def poll(campaign)
        raise "Overwrite me!"
      end

    end
  end
end


require_relative "scheduled/campaigns_handler.rb"

require_relative "regular/poll_twitter_user.rb"
require_relative "regular/poll_website_feed.rb"
require_relative "regular/poll_youtube_channel.rb"
