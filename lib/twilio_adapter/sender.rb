module TwilioAdapter
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
