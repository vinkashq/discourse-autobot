module Autobot
  module Website
    class PostCreator < Autobot::PostCreator

      def initialize(campaign, article_rss_item)
        super(campaign)
        @article_rss_item = article_rss_item
      end

      def title
        @article_rss_item.title.force_encoding("UTF-8").scrub
      end

      def content
        content = @article_rss_item.content_encoded&.force_encoding("UTF-8")&.scrub ||
                    @article_rss_item.content&.force_encoding("UTF-8")&.scrub ||
                    @article_rss_item.description&.force_encoding("UTF-8")&.scrub
        content += "\n\n #{featured_link}"

        content
      end

      def display_featured_link?
        true
      end

      def source_url
        link = @article_rss_item.link
        if url?(link)
          return link
        else
          return @article_rss_item.id
        end
      end

      def image_url
        @article_rss_item.enclosure_url
      end

      private

        def url?(link)
          if link.blank? || link !~ /^https?\:\/\//
            return false
          else
            return true
          end
        end

    end
  end
end
