require_dependency 'yt'

module Jobs
  class PollYoutubeChannel < Jobs::AutobotCampaign

    def execute(args)
      channel = ::Yt::Channel.new id: campaign["key"]
      videos = channel.videos
      last_polled_at = campaign["last_polled_at"]
      videos = videos.where(publishedAfter: last_polled_at) if last_polled_at.present?
      video = videos.first
      return unless video

      creator = Autobot::Youtube::PostCreator.new(campaign, video)
      post = creator.create
    end

  end
end
