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
					messages << Sms::Message.receive_from_phone_number(
						sms[:phone_number],
						sms[:message],
						sms[:id],
						sms[:time])
				end
				Adapters::Gammu::Connection.clear_received
				messages
			end
		end
	end
end
