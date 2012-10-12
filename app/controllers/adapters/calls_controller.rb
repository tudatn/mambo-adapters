# -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Adapters
	class CallsController < BaseController
		respond_to(:html)

	protected
		#
		def handle_request
			to, from, sid, status = format_call_params(params)

			response = yield(to, from, status, sid)

			respond_to do |format|
				format.html { render(:xml => response) }
			end
		end

		#
		def format_call_params(params)
			[
				Formatter.format_phone_number(params[:To]),
				Formatter.format_phone_number(params[:From]),
				Formatter.format_status(params[:CallStatus]),
				Formatter.format_sid(params[:CallSid]),
			]
		end

		#
		def play(url)
			twiml = Twilio::TwiML.build do |response|
				if !url.nil?
					response.play(url)
				end
			end
		end
	end
end
