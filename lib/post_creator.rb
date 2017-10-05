module Autobot
  class PostCreator

    def initialize(campaign)
      @campaign = campaign
    end

    def user
      Discourse.system_user
    end

    def title
      raise "Overwrite me!"
    end

    def raw
      raise "Overwrite me!"
    end

    def raw_with_title
%{## #{self.title}

#{self.raw}}
    end

    def cook_method
      Post.cook_methods[:raw_html]
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

    def params
      {}.tap do |h|
        h[:title] = title if new_topic?
        h[:raw] = new_topic? ? raw : raw_with_title
        h[:skip_validations] = skip_validations
        h[:cook_method] = cook_method
        h[:category] = category if new_topic?
        h[:topic_id] = topic_id unless new_topic?
      end
    end

    def create
      creator = ::PostCreator.new(user, params)
      post = creator.create
    end

  end
end
