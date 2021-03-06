class Category < ActiveRecord::Base
  has_many :article_categories
  has_many :articles, through: :article_categories
  has_many :announcement_categories
  has_many :announcements, through: :announcement_categories
  has_many :faq_categories
  has_many :faqs, through: :faq_categories
  validates :name, presence: true, length: { minimum: 2, maximum: 25 }
  validates_uniqueness_of :name
  acts_as_followable

    def self.search(param)
      param.strip!
      param.downcase!
      to_send_back = (name_matches(param)).uniq
      return nil unless to_send_back
      to_send_back
    end
    
    def self.name_matches(param)
      matches('name', param)
    end
    def self.matches(field_name, param)
      if Rails.env.development?
        Category.where("#{field_name} like ?", "%#{param}%")
      else
        Category.where("#{field_name} ilike ?", "%#{param}%")
      end
    end
end