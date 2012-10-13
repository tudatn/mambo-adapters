# -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Adapters::Gammu
	class Poller < Adapters::Poller
		# instance methods
		def poll
			ActiveRecord::Base.transaction do
				messages = []
				Adapters::Gammu::Connection.received.each do |sms|

					phone_number = Formatter.format_phone_number(sms[:phone_number])

					subscriber = Sms::Subscriber.first_by_phone_number(phone_number)

					if subscriber
						messages << subscriber.receive_message(
							Formatter.format_body(sms[:message]),
							Formatter.format_sid(sms[:id]),
							Formatter.format_date(sms[:time]))
					else
						messages << Sms::Message.receive_message(
							phone_number,
							Formatter.format_body(sms[:message]),
							Formatter.format_sid(sms[:id]),
							Formatter.format_date(sms[:time]))
					end
				end
				Adapters::Gammu::Connection.clear_received
				messages
			end
		end
	end
end
