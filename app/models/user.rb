class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :capitalize_names

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, 
         :validatable, :authentication_keys => [:login]
  
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 8, maximum: 8 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
  validates :first_name, presence: true
  validates :last_name, presence: true
  # validates :expiration_date, presence: true
  validates_date :expiration_date, :after => :today



  def login=(login)
    @login = login
  end

  def login
    @login || self.username || self.email
  end

  
  private

	def capitalize_names
	  self.first_name = first_name.titleize
	  self.last_name = modify_last_name(last_name)
	end

  def modify_last_name(name)
    name = name.downcase
    if name.include? "-"
      name.gsub!(/-/, ' ')
      name = name.titleize
      name.gsub!(/ /, '-')
    else
      name.titleize
    end
  end
  
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    else
      where(conditions.to_h).first
    end
  end

end
