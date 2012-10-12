class Adapters::Gammu::InboxItem < ActiveRecord::Base
  def self.table_name
  	"inbox"
  end
end
