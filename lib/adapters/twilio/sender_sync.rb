# -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

require "adapters/sender"

module Adapters::Twilio
	class SenderSync < Sender
		#
		def send(message)
			sms = Twilio::SMS.create(
				:to => message.phone_number,
				:from => self.phone_number,
				:body => message.body,
			)

			message.status = :sent
			message.sid = Formatter.format_sid(sms.sid)
			message.save
		end
	end
end
