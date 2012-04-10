module TwilioAdapter
  class Engine < Rails::Engine
    isolate_namespace TwilioAdapter

    config.before_initialize do
			require("twilio-rb")
    end
  end
end
