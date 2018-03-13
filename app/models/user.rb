class User < ActiveRecord::Base
  #acts_as_paranoid#needed for soft delete // its part of the Gem
  #to check deleted users in Rails c -> User.with_deleted.all
  #example of restore: User.with_deleted.find(2).restore    
  acts_as_voter
  
  has_many :socialposts # , dependent: :destroy /////this needs to be added if we want the posts deleted once a user is deleted
  has_many :comments # , dependent: :destroy /////same as above
  has_many :notifications, dependent: :destroy
  has_many :articles, dependent: :destroy
  has_many :announcements, dependent: :destroy
  has_many :article_comments
  has_many :announcement_comments
  
  has_attached_file :avatar, styles: { medium: '152x152#' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  
  before_save { self.email = email.downcase }
  validates :username, presence: true, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /(\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z)?(@zappistore.com)/i
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  

  #roles available in the profile/sign up
  enum role: {'None': 0, 'Developer': 1, 'Support': 2, 'Product Owner': 3, 'Research': 4, 'Client Excelence': 5, 'Sales': 6, 'Office Manager': 7}
  
  
  def self.search(param)
    param.strip!
    param.downcase!
    to_send_back = (first_name_matches(param) + last_name_matches(param) + email_matches(param) + username_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end
  
  def self.first_name_matches(param)
    matches('first_name', param)
  end
  def self.last_name_matches(param)
    matches('last_name', param)
  end
  def self.email_matches(param)
    matches('email', param)
  end
  def self.username_matches(param)
    matches('username', param)
  end
  
  def self.matches(field_name, param)
    User.where("#{field_name} like ?", "%#{param}%")
  end
  
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
         

end
