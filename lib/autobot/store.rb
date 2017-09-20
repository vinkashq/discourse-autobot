module Autobot
  class Store
    def self.set(key, value)
      ::PluginStore.set(Autobot::PLUGIN_NAME, key, value)
    end

    def self.get(key)
      ::PluginStore.get(Autobot::PLUGIN_NAME, key)
    end

    def self.remove(key)
      ::PluginStore.remove(Autobot::PLUGIN_NAME, key)
    end
  end
end
