module Adapters
	class Poller
		# instance methods
		#
		def initialize(phone_number)
			@phone_number = phone_number
		end

		#
		def poll
			raise("Not implemented: please subclass Adapters::Poller")
		end
	end
end