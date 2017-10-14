require_dependency 'yt'

module Jobs
  class PollYoutubeChannel < Autobot::Jobs::Base

    def poll(campaign)
      Autobot::Youtube::Provider.configure
      last_polled_at = campaign[:last_polled_at]

      channel = ::Yt::Channel.new id: campaign[:key]
      videos = channel.videos
      videos = videos.where(publishedAfter: last_polled_at) if last_polled_at.present?

      videos.each do |video|
        creator = Autobot::Youtube::PostCreator.new(campaign, video)
        creator.create!
        return unless last_polled_at.present?
      end
    end

  end
end
