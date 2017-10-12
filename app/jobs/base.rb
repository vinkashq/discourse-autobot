module Autobot
  module Jobs
    class Base < ::Jobs::Base
      attr_accessor :campaign

      def last_polled_at
        @campaign["last_polled_at"]
      end

      def execute(args)
        @campaign = Autobot::Campaign.find(args[:campaign_id])

        poll(@campaign)

        @campaign["last_polled_at"] = Time.now
        Autobot::Campaign.update(@campaign)
      end

      def poll(campaign)
        raise "Overwrite me!"
      end

    end
  end
end
