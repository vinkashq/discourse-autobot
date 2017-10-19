module Autobot
  module Youtube
    class PostCreator < Autobot::PostCreator

      def initialize(campaign, yt_video)
        super(campaign)
        @video = yt_video
      end

      def title
        @video.snippet.title
      end

      def content
%{https://www.youtube.com/watch?v=#{@video.id}

#{@video.snippet.description}}
      end

      def source_url
        "https://www.youtube.com/watch?v=#{@video.id}"
      end

    end
  end
end
