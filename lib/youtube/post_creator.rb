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

      def raw
%{https://www.youtube.com/watch?v=#{@video.id}

#{@video.snippet.description}}
      end

    end
  end
end
