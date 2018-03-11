class Article < ActiveRecord::Base
    validates :title, presence: true, length:{ minimum: 3, maximum: 200 }
    validates :description, presence: true, length:{ minimum: 3, maximum: 500 }
    validates :body, presence: true, length:{ minimum: 3, maximum: 5000 }
    belongs_to :user
    validates :user_id, presence: true
    
    has_many :article_categories
    has_many :categories, through: :article_categories
    has_many :article_comments
    
    def self.search(param)
      param.strip!
      param.downcase!
      to_send_back = (title_matches(param) + description_matches(param) + body_matches(param)).uniq
      return nil unless to_send_back
      to_send_back
    end
    
    def self.title_matches(param)
      matches('title', param)
    end
    def self.description_matches(param)
      matches('description', param)
    end
    def self.body_matches(param)
      matches('body', param)
    end
    
    def self.matches(field_name, param)
      Article.where("#{field_name} like ?", "%#{param}%")
    end
    
    
end