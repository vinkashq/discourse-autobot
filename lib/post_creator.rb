module Autobot
  class PostCreator

    def initialize(campaign)
      @campaign = campaign
    end

    def user
      Autobot.autobot_user
    end

    def title
      raise "Overwrite me!"
    end

    def content
      raise "Overwrite me!"
    end

    def raw
      raw = ""
      raw << "## #{title}\n\n" if new_topic?
      raw << "#{image_url}\n\n" if image_url.present?
      raw << content

      raw
    end

    def cook_method
      Post.cook_methods[:regular]
    end

    def skip_validations
      true
    end

    def category
      @campaign["category_id"]
    end

    def topic_id
      @campaign["topic_id"]
    end

    def new_topic?
      topic_id.blank?
    end

    def featured_link
      nil
    end

    def image_url
      nil
    end

    def params
      {}.tap do |h|
        h[:title] = title if new_topic?
        h[:raw] = raw
        h[:skip_validations] = skip_validations
        h[:cook_method] = cook_method
        h[:category] = category if new_topic?
        h[:topic_id] = topic_id unless new_topic?
        h[:featured_link] = featured_link if new_topic? && featured_link.present?
      end
    end

    def create
      creator = ::PostCreator.new(user, params)
      post = creator.create
    end

  end
end
