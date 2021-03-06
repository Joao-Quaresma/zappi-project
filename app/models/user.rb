class User < ActiveRecord::Base
  acts_as_paranoid
  #to check deleted users in Rails c -> User.with_deleted.all
  #example of restore: User.with_deleted.find(2).restore    
  acts_as_voter
  acts_as_follower
  acts_as_followable
  act_as_bookmarker
  
  has_many :socialposts # , dependent: :destroy /////this needs to be added if we want the posts deleted once a user is deleted
  has_many :comments
  has_many :notifications
  has_many :articles
  has_many :announcements
  has_many :article_comments
  has_many :announcement_comments
  has_many :articlenotifications
  has_many :announcementnotifications
  has_many :faqs
  has_many :faq_comments
  has_many :faqnotifications
  
  has_attached_file :avatar, styles: { medium: '200x200#' }
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/
  
  
  before_save { self.email = email.downcase }
  validates :username, presence: true, format: { without: /\s/ }, uniqueness: { case_sensitive: false }, length: { minimum: 3, maximum: 25 }
  VALID_EMAIL_REGEX = /(\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z)?(@zappistore.com)/i
  validates :email, presence: true, length: { maximum: 105 }, uniqueness: { case_sensitive: false }, format: { with: VALID_EMAIL_REGEX }
  validates :resume, length: { maximum: 4000 }

  #roles available in the profile/sign up
  enum role: {'None': 0, 'Developer': 1, 'Support': 2, 'Product Owner': 3, 'Research': 4, 'Client Excelence': 5, 'Sales': 6, 'Office Manager': 7}
  

  def self.search(param)
    param.strip!
    param.downcase!
    to_send_back = (username_matches(param) + first_name_matches(param) + last_name_matches(param) + email_matches(param)).uniq
    return nil unless to_send_back
    to_send_back
  end
  
  def self.username_matches(param)
    matches('username', param)
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
  
  def to_param
  username
  end


  def self.matches(field_name, param)
    if Rails.env.development?
      User.where("#{field_name} like ?", "%#{param}%")
    else
      User.where("#{field_name} ilike ?", "%#{param}%")
    end
  end

  
  devise :database_authenticatable, :registerable, :lockable,
         :recoverable, :rememberable, :trackable, :validatable
         

end
