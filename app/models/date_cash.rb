class DateCash < ActiveRecord::Base
  
  attr_accessible :date_cash
  
  validates :date_cash, :presence => :true

end
