require_dependency 'yt'

module Jobs
  class PollYoutube < Jobs::AutobotCampaign

    def execute(args)
      channel = ::Yt::Channel.new id: campaign["key"]
      SiteSetting.title = channel.title
    end

  end
end
