module TwilioAdapter
	class CallsController < BaseController
		respond_to(:html)

	protected
		#
		def handle_request
			begin
				to, from, sid, status = format_call_params(params)
				response = do_request(to, from, sid, status)
				logger.debug(response)
			rescue => error
				logger.error(error)
				response = do_failure
			ensure
				respond_with(response) do |format|
					format.html { render(:xml => response) }
				end
			end
		end

		#
		def format_call_params(params)
			[
				TwilioFormatter.format_phone_number(params[:To]),
				TwilioFormatter.format_phone_number(params[:From]),
				TwilioFormatter.format_sid(params[:CallSid]),
				TwilioFormatter.format_status(params[:CallStatus])
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
