module Adapters::Gammu
  class Connection < Adapters::Connection
    def self.send_test_sms(phone_number, message)
      begin
        self.write
        self.reset
        success = system "echo \"#{message}\" | /usr/bin/gammu --sendsms TEXT #{phone_number}"
        return success
      rescue Exception => e
        raise e.inspect if Rails.env.development?
        return false
      end
    end

    def self.send_sms(phone_number, message)
			query = <<-q
				INSERT INTO outbox (DestinationNumber, TextDecoded, CreatorID, Coding)
				VALUES ('#{phone_number}', '#{message}', 'Weltel System', 'Default_No_Compression');
			q
			ActiveRecord::Base.connection.execute(query)
      true
    end

    def self.received
      Adapters::Gammu::InboxItem.all.map do |item|
        {
        	:id => item.read_attribute(:ID),
          :phone_number => item.read_attribute(:SenderNumber),
          :message => item.read_attribute(:TextDecoded),
          :time => item.read_attribute(:ReceivingDateTime)
        }
      end
    end

    def self.clear_received
      Adapters::Gammu::InboxItem.destroy_all
    end
  end
end
