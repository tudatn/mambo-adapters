# -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Adapters::Twilio
	class Sender
		#
		def initialize(phone_number)
			@phone_number = phone_number
		end

	protected
		#
		attr_reader(:phone_number)
	end
end
