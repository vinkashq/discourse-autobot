module Jobs
  class PollTwitterUser < Autobot::Jobs::Base

    def poll(campaign)
      @username = campaign[:key]
      since_id = campaign[:since_id].presence

      tweets = TwitterApi.user_timeline({screen_name: @username, since_id: since_id})
      tweets.reverse_each do |tweet|
        creator = Autobot::Twitter::PostCreator.new(campaign, tweet)
        creator.create!
      end
    end

  end
end
