# -*- encoding : utf-8 -*-
#- This Source Code Form is subject to the terms of the Mozilla Public
#- License, v. 2.0. If a copy of the MPL was not distributed with this
#- file, You can obtain one at http://mozilla.org/MPL/2.0/.

module Adapters
  class Engine < Rails::Engine
    isolate_namespace Adapters

		#
    config.before_initialize do
			require("twilio-rb")
			Twilio::SMS.default_timeout(30)
    end
  end
end
