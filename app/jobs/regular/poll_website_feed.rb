require 'open-uri'

module Jobs
  class PollWebsiteFeed < Autobot::Jobs::Base
    require 'simple-rss'

    def execute(args)
      @feed_url = campaign[:key]
      last_polled_at = campaign[:last_polled_at]

      rss = fetch_rss
      if rss.present?
        if last_polled_at.present?
          build_date = rss.channel.lastBuildDate || rss.channel.pubDate
          return if build_date.present? && build_date < last_polled_at
        end

        rss.items.each do |i|
          creator = Autobot::Website::PostCreator.new(campaign, i)
          creator.create
          return unless last_polled_at.present?
        end
      end
    end

    private

      def fetch_rss
        SimpleRSS.parse open(@feed_url, allow_redirections: :all)
      rescue OpenURI::HTTPError, SimpleRSSError
        nil
      end

  end
end
