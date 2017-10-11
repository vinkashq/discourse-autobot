module Jobs
  class AutobotCampaign < Jobs::Base
    attr_accessor :campaign

    def last_polled_at
      @campaign["last_polled_at"]
    end

    def perform(*args)
      opts = args.extract_options!.with_indifferent_access
      @id = opts[:campaign_id]
      @campaign = Autobot::Campaign.find(@id)

      super

      @campaign["last_polled_at"] = Time.now
      Autobot::Campaign.update(@campaign)
    end

  end
end
