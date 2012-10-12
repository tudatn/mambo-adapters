# -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Adapters::Twilio
	module Formatter
		#
		def self.format_phone_number(phone_number)
			return nil if phone_number.nil?
			phone_number.gsub(/^[^\d]?1?[^\d]*/, "")
		end

		#
		def self.format_body(body)
			return "" if body.nil?
			# hack, upgrade mysql to 5.5 for proper unicode support
			body.strip.gsub("\xF0\x9F\x98\x84", "")
		end

		#
		def self.format_sid(sid)
			return nil if sid.nil?
			sid.strip
		end

		#
		def self.format_status(status)
			return nil if status.nil?
			status.strip.downcase.to_sym
		end

		#
		def self.format_date(date)
			Time.parse(date).localtime
		end
	end
end