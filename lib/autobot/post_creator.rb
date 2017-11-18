module Autobot
  class PostCreator

    def initialize(campaign)
      @campaign = campaign
    end

    def owner
      username = @campaign[:owner_username]
      return unless username.present?

      User.find_by(username: username)
    end

    def default_user
      Autobot.user || Discourse.system_user
    end

    def title
      raise "Overwrite me!"
    end

    def content
      raise "Overwrite me!"
    end

    def source_url
      raise "Overwrite me!"
    end

    def raw
      raw = ""
      raw << "## #{title}\n\n" unless new_topic?
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

    def display_featured_link?
      false
    end

    def image_url
      nil
    end

    def custom_fields
      {
        autobot_campaign_id: @campaign["id"],
        autobot_source_url: source_url
      }
    end

    def params
      {}.tap do |h|
        h[:title] = title if new_topic?
        h[:raw] = raw
        h[:skip_validations] = skip_validations
        h[:cook_method] = cook_method
        h[:category] = category if new_topic?
        h[:topic_id] = topic_id unless new_topic?
        h[:featured_link] = source_url if new_topic? && display_featured_link?
        h[:custom_fields] = custom_fields
      end
    end

    def create!
      post = existing || creator.create!
    end

    def existing
      return PostCustomField.where(name: "autobot_source_url", value: source_url).first.try(:post)
    end

    private

      def creator
        user = owner || default_user

        ::PostCreator.new(user, params)
      end

  end
end
