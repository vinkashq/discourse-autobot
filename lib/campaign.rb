module Autobot
  class Campaign
    KEY = 'campaign'.freeze

    def self.list
      Autobot::Store.get(KEY) || []
    end

    def self.set(value)
      Autobot::Store.set(KEY, value)
    end

    def self.create(value)
      data = list
      value["id"] = SecureRandom.uuid

      data.push(value)
      set(data)

      value["id"]
    end

    def self.update(value)
      data = list

      index = data.index do |i|
        i["id"] == value["id"]
      end

      return create(value) unless index

      data[index].merge!(value.except(:id))
      set(data)

      value["id"]
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
