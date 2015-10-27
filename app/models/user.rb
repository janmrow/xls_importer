class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  before_save :capitalize_names

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 8, maximum: 8 }
  validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/ }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :expiration_date, presence: true

  private
  
	  def capitalize_names
	    self.first_name = first_name.camelcase
	    self.last_name = last_name.camelcase
	  end

end
