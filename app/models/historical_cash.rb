class HistoricalCash < ActiveRecord::Base
  
  attr_accessible :description
  
  has_many :cashes
  
  validates :description, :presence => :true
  
  def self.search(campo, chave, page)
    paginate :per_page => 10, :page => page,
             :conditions => ["LOWER(#{campo}) like ? ", "#{chave}%".downcase],
             :order => "#{campo}"
  end  
  
end
