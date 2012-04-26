module TwilioAdapter
	class Poller
		# instance methods
		#
		def initialize(phone_number)
			@phone_number = phone_number
		end

		#
		def poll
			created_after = 1.week.ago.utc.to_date

			smses = []

			# count smses
			count = Twilio::SMS.count(:to => @phone_number, :created_after => created_after)

			# number of pages
			pages = (count / 1000).floor + 1

			# get smses in pages
			pages.times do |page|
				smses += Twilio::SMS.all(:to => @phone_number, :created_after => created_after, :page => page, :page_size => 1000)
			end

			# filter smses
			smses.select! do |sms|
				sms.direction == "inbound" && !Sms::Message.first_by_sid(Formatter.format_sid(sms.sid))
			end

			# create messages
			messages = smses.map do |sms|
				Sms::Message.receive_from_phone_number(
					Formatter.format_phone_number(sms.from),
					Formatter.format_body(sms.body),
					Formatter.format_sid(sms.sid),
					Formatter.format_date(sms.date_created)
				)
			end

			messages
		end
	end
end
