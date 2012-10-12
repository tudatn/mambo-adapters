module Adapters
  class Connection
    def self.available_devices
      lines = `ls /dev/ttyUSB* -l`.split
      lines.map {|l| l.match(/ttyUSB\w*/) }.compact.map{|port| "/dev/#{port}"}.uniq
    end

    def self.valid_keys
      [:device, :extra]
    end

    def self.send_test_sms(phone_number, message)
      raise("Not implemented: please subclass Adapters::Connection")
    end

    def self.send_sms(phone_number, message)
      raise("Not implemented: please subclass Adapters::Connection")
    end

    def self.reset
      raise("Not implemented: please subclass Adapters::Connection")
    end

    def self.received
      raise("Not implemented: please subclass Adapters::Connection")
    end
  end
end
