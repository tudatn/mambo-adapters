module TwilioAdapter
	class CallsController < BaseController
		respond_to(:html)

	protected
		#
		def handle_request
			begin
				to, from, sid, status = format_call_params(params)

				response = yield(to, from, status, sid)

			rescue => error
				logger.error(error)
				logger.error(error.backtrace)
				response = Twilio::TwiML.build
			end

			respond_to do |format|
				format.html { render(:xml => response) }
			end
		end

		#
		def format_call_params(params)
			[
				TwilioFormatter.format_phone_number(params[:To]),
				TwilioFormatter.format_phone_number(params[:From]),
				TwilioFormatter.format_status(params[:CallStatus]),
				TwilioFormatter.format_sid(params[:CallSid]),
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
