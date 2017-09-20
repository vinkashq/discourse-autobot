# name: autobot
# about: Automatic content creator bot for Discourse
# version: 0.0.1
# authors: Vinoth Kannan (@vinothkannans)
# url: https://github.com/vinkashq/discourse-autobot

enabled_site_setting :discourse_autobot_enabled

after_initialize do
  SeedFu.fixture_paths << Rails.root.join("plugins", "autobot", "db", "fixtures").to_s

  module ::DiscourseAutobot
    PLUGIN_NAME = "autobot".freeze

    class Engine < ::Rails::Engine
      engine_name PLUGIN_NAME
      isolate_namespace DiscourseAutobot
    end

    class Store
      def self.set(key, value)
        ::PluginStore.set(PLUGIN_NAME, key, value)
      end

      def self.get(key)
        ::PluginStore.get(PLUGIN_NAME, key)
      end

      def self.remove(key)
        ::PluginStore.remove(PLUGIN_NAME, key)
      end
    end
  end
end
