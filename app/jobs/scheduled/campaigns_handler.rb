module Jobs
  class CampaignsHandler < Jobs::Scheduled
    every 5.minutes

    sidekiq_options retry: false

    def execute(args)
      campaigns = ::Autobot::Campaign.list

      campaigns.each do |c|
        # if c["last_polled_at"].present?
        #   polling_frequency = 10 # c["polling_frequency"].minutes
        #   last_polled_at = c["last_polled_at"].to_datetime.minutes

        #   next if last_polled_at + polling_frequency > Time.now.minutes
        # end
        case c["provider_id"]
        when "1" # YouTube
          Jobs.enqueue(:poll_youtube, campaign_id: c["id"])
        end
      end
    end
  end
end
