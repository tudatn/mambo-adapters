# -*- encoding : utf-8 -*-
require "twilio_adapter/sender"

module TwilioAdapter
	class SenderAsync < Sender

		#
		def initialize(phone_number, &url_helper)
			super(phone_number)
			@url_helper = url_helper
		end

		#
		def send(message)
			sms = Twilio::SMS.create(
				:to => message.phone_number,
				:from => phone_number,
				:body => message.body,
				:status_callback => self.url_helper(message)
			)

			message.sid = Formatter.format_sid(sms.sid)
			message.save
			message
		end

	protected
		#
		attr_reader(:url_helper)
	end
end
