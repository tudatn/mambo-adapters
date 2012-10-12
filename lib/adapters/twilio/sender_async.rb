# -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "adapters/sender"

module Adapters::Twilio
	class SenderAsync < Adapters::Sender
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
