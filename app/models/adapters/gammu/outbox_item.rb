class Adapters::Gammu::OutboxItem < ActiveRecord::Base
  def self.table_name
  	'outbox'
  end
end
