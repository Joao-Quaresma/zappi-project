class User < ActiveRecord::Base
  acts_as_paranoid
  has_many :socialposts, dependent: :destroy
  
  before_save { self.email = email.downcase }
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /(\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z)?(@zappistore.com)/i
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  
  #roles available in the profile/sign up
  enum role: {'None': 0, 'Developer': 1, 'Support': 2, 'Product Owner': 3, 'Research': 4, 'Client Excelence': 5, 'Sales': 6, 'Office Manager': 7}
  
   # instead of deleting, indicate the user requested a delete & timestamp it  
  def soft_delete  
    update_attribute(:deleted_at, Time.current)  
  end  
  
  # ensure user account is active  
  def active_for_authentication?  
    super && !deleted_at  
  end  
  
  # provide a custom message for a deleted account   
  def inactive_message   
  	!deleted_at ? super : :deleted_account  
  end  
  
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
