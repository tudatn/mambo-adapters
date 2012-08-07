# -*- encoding : utf-8 -*-
require "rails/all"
require "twilio-rb"
require "mambo-sms"

module TwilioAdapter
end

require "twilio_adapter/version"
require "twilio_adapter/engine"
require "twilio_adapter/formatter"
require "twilio_adapter/sender_async"
require "twilio_adapter/sender_sync"
require "twilio_adapter/poller"
