# -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Adapters::Twilio
	class MessagesController < Adapters::BaseController

	protected
		#
		def handle_request
			to, from, body, sid, status = format_request_params(params)

			response = yield(to, from, body, sid)

			respond_to do |format|
				format.html { render(:xml => response || Twilio::TwiML.build) }
			end
		end

		#
		def handle_status_callback
			to, from, sid, status = format_status_callback_params(params)

			response = yield(to, from, status, sid)

			respond_to do |format|
				format.html { render(:xml => response || Twilio::TwiML.build) }
			end
		end

		#
		def format_request_params(params)
			[
				Formatter.format_phone_number(params[:To]),
				Formatter.format_phone_number(params[:From]),
				Formatter.format_body(params[:Body]),
				Formatter.format_sid(params[:SmsSid]),
				Formatter.format_status(params[:SmsStatus])
			]
		end

		#
		def format_status_callback_params(params)
			[
				Formatter.format_phone_number(params[:To]),
				Formatter.format_phone_number(params[:From]),
				Formatter.format_sid(params[:SmsSid]),
				Formatter.format_status(params[:SmsStatus]),
			]
		end

		#
		def respond(message, status_callback)
			twiml = Twilio::TwiML.build do |response|
				if !message.nil?
					response.sms(message.body, :status_callback => status_callback)
				end
			end
		end
	end
end
