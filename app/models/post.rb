class Post < ActiveRecord::Base
  # attr_accessible :title, :body
  
  attr_accessible :visible, :title, :photo, :photo_content_type, :photo_file_name, :photo_file_size
  
  has_attached_file :photo, :styles => {
           :medium => "400X300#",
           :thumb => "150X150#",
       },
       :url => "/post/:attachment/:id/:style/:basename.:extension",  
       :path => ":rails_root/public/post/:attachment/:id/:style/:basename.:extension"
    
  def self.search(campo, chave, page)
    paginate :per_page => 10, :page => page,
             :conditions => ["LOWER(#{campo}) like ? ", "#{chave}%".downcase],
             :order => "#{campo}"
  end  
  
end
