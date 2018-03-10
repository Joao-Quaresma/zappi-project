class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :socialpost
  validates :content, presence: true, length: { minimum: 1, maximum: 500 }
end
