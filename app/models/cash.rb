class Cash < ActiveRecord::Base
  
  attr_accessible :date_cash, :value_cash, :description, :type_cash, :type_payment, :historical_cash_id
  
  belongs_to :historical_cash
  
  validates :description, :type_cash, :type_payment, :historical_cash_id, :presence => true
  
end
