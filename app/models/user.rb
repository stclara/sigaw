class User < ActiveRecord::Base
  # attr_accessible :title, :body
  
  attr_accessible :name, :mail, :password, :password_confirmation, :adm, :ger, :opr, :est, :cxa, :pag, :rec
  
  attr_accessor :password
  before_save :encrypt_password
  
  validates :password, :presence => true, :confirmation => true
  validates :mail, :presence => true, :uniqueness => true

  def self.search(campo, chave, page)
    paginate :per_page => 10, :page => page,
             :conditions => ["LOWER(#{campo}) like ? ", "#{chave}%".downcase],
             :order => "#{campo}"
  end

  def encrypt_password
    if password.present?
      self.password_salt = BCrypt::Engine.generate_salt
      self.password_hash = BCrypt::Engine.hash_secret(password, password_salt)
    end
  end

  def self.authenticate(mail, password)
    user = find_by_mail(mail)
    if user && user.password_hash == BCrypt::Engine.hash_secret(password, user.password_salt)
      user
    else
      nil
   end
  end
  
end
