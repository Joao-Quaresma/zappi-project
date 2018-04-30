class Announcement < ActiveRecord::Base
    validates :title, presence: true, length:{ minimum: 3, maximum: 200 }
    validates :description, presence: true, length:{ minimum: 3, maximum: 1000 }
    validates :body, presence: true, length:{ minimum: 3, maximum: 10000 }
    belongs_to :user
    validates :user_id, presence: true
    
    has_many :announcement_categories
    has_many :categories, through: :announcement_categories
    has_many :announcement_comments
    has_many :announcementnotifications, dependent: :destroy
    act_as_bookmarkee
    acts_as_followable

    def user
      User.unscoped { super }
    end
    
    def self.search(param)
      param.strip!
      param.downcase!
      to_send_back = (title_matches(param) + description_matches(param)).uniq
      return nil unless to_send_back
      to_send_back
    end
    
    def self.title_matches(param)
      matches('title', param)
    end
    def self.description_matches(param)
      matches('description', param)
    end
    
    def self.matches(field_name, param)
      if Rails.env.development?
        Announcement.where("#{field_name} like ?", "%#{param}%")
      else
        Announcement.where("#{field_name} ilike ?", "%#{param}%")
      end
    end
    
    
    
    
end