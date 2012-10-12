class Adapters::Gammu::OutboxItem < ActiveRecord::Base
  self.table_name
  	'outbox'
  end
end
