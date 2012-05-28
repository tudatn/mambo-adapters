# -*- encoding : utf-8 -*-
module TwilioAdapter
  class Engine < Rails::Engine
    isolate_namespace TwilioAdapter

		#
    config.before_initialize do
			require("twilio-rb")
			Twilio::SMS.default_timeout(30)
    end
  end
end
