#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

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
