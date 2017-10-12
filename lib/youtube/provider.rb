require_dependency 'yt'

module Autobot
  module Youtube
    module Provider

      def self.configure
        Yt.configure do |config|
          config.api_key = SiteSetting.google_api_server_key
        end
      end

    end
  end
end

require_relative "initializer.rb"
require_relative "post_creator.rb"
