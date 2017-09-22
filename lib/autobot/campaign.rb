module Autobot
  class Campaign
    KEY = 'campaign'.freeze

    def self.list
      Autobot::Store.get(KEY) || []
    end

    def self.set(value)
      Autobot::Store.set(KEY, value)
    end

    def self.create(source_id, key, category_id = nil, topic_id = nil, interval = 10.minutes)
      data = list
      id = SecureRandom.uuid

      data.push(id: id, source_id: source_id, topic_id: topic_id, category_id: category_id, key: key, interval: interval)
      set(data)

      id
    end

    def self.delete(id)
      data = list

      data.delete_if do |i|
        i['id'] == id
      end

      set(data)
    end
  end
end
