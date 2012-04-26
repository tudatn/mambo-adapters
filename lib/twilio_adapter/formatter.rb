module TwilioAdapter
	module Formatter
		#
		def self.format_phone_number(phone_number)
			return nil if phone_number.nil?
			phone_number.gsub(/^\+?1?[^\d]*/, "")
		end

		#
		def self.format_body(body)
			return "" if body.nil?
			body.strip
		end

		#
		def self.format_sid(sid)
			return nil if sid.nil?
			sid.strip
		end

		#
		def self.format_status(status)
			return nil if status.nil?
			status.strip.capitalize.to_sym
		end

		#
		def self.format_date(date)
			Time.parse(date).localtime
		end
	end
end
