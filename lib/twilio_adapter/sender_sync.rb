# -*- encoding : utf-8 -*-
require "twilio_adapter/sender"

module TwilioAdapter
	class SenderSync < Sender
		#
		def send(message)
			sms = Twilio::SMS.create(
				:to => message.phone_number,
				:from => self.phone_number,
				:body => message.body,
			)

			message.status = :Sent
			message.sid = Formatter.format_sid(sms.sid)
			message.save
		end
	end
end
