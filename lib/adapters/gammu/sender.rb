# -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Adapters::Gammu
	class Sender < Adapters::Sender
		def send(message)
			result = Adapters::Gammu::Connection.send_sms(message.phone_number, message.body)
			message.status = result ? :sent : :failed
			message.save!
		end
	end
end
