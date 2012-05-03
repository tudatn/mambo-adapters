module TwilioAdapter
	class MessagesController < BaseController

	protected
		#
		def handle_request
			begin
				to, from, body, sid, status = format_request_params(params)

				response = yield(to, from, body, sid)

				respond_to do |format|
					format.html { render(:xml => response || Twilio::TwiML.build) }
				end

			rescue => error
				logger.error(error)
				logger.error(error.backtrace)

				respond_to do |format|
					format.html { render(:xml => Twilio::TwiML.build) }
				end
			end
		end

		#
		def handle_status_callback
			begin
				to, from, status, sid = format_status_callback_params(params)

				response = yield(to, from, status, sid)

				respond_to do |format|
					format.html { render(:xml => response || Twilio::TwiML.build) }
				end

			rescue => error
				logger.error(error)

				respond_to do |format|
					format.html { render(:xml => Twilio::TwiML.build) }
				end
			end
		end

		#
		def format_request_params(params)
			[
				Formatter.format_phone_number(params[:To]),
				Formatter.format_phone_number(params[:From]),
				Formatter.format_body(params[:Body]),
				Formatter.format_sid(params[:SmsSid])
			]
		end

		#
		def format_status_callback_params(params)
			[
				Formatter.format_phone_number(params[:To]),
				Formatter.format_phone_number(params[:From]),
				Formatter.format_status(params[:SmsStatus]),
				Formatter.format_sid(params[:SmsSid])
			]
		end

		#
		def reply(message, status_callback)
			twiml = Twilio::TwiML.build do |response|
				if !message.nil?
					response.sms(message.body, :status_callback => status_callback)
				end
			end
		end
	end
end
