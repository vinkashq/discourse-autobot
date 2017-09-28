module Jobs
  class PollCampaign < Jobs::Scheduled
    every 5.minutes

    sidekiq_options retry: false

    def execute(args)
    end
  end
end
