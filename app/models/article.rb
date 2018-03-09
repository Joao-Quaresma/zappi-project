class Article < ActiveRecord::Base
    validates :title, presence: true, length:{ minimum: 3, maximum: 100 }
    validates :description, presence: true, length:{ minimum: 3, maximum: 300 }
    validates :body, presence: true, length:{ minimum: 3, maximum: 2000 }
    belongs_to :user
    validates :user_id, presence: true
    
    has_many :article_categories
    has_many :categories, through: :article_categories
end