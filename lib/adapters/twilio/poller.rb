# -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Adapters::Twilio
	class Poller < ::Adapters::Poller
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

			messages = []

			smses.each do |sms|
				next if sms.direction != "inbound"

				from = Formatter.format_phone_number(sms.from)
				body = Formatter.format_body(sms.body)
				sid = Formatter.format_sid(sms.sid)
				created = Formatter.format_date(sms.date_created)

				Sms::Message.transaction do
					next if Sms::Message.first_by_sid(sid)

					# subscriber
					subscriber = Sms::Subscriber.find_by_phone_number(from)

					# create message
					if subscriber
						messages << subscriber.receive_message(body, sid)
					else
						messages << Sms::Message::receive_message(from, body, sid)
					end
				end
			end

			messages
		end
	end
end
