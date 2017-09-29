require_dependency 'yt'

module Jobs
  class PollYoutube < Jobs::Base

    def execute(args)
      ::Yt.configure do |config|
        config.api_key = SiteSetting.google_api_server_key
      end

      campaign_id = args[:campaign_id]

      campaign = Autobot::Campaign.find(campaign_id)

      channel = ::Yt::Channel.new id: campaign["key"]
      SiteSetting.title = channel.title
    end

  end
end
