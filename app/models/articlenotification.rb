class Articlenotification < ActiveRecord::Base
  belongs_to :user
  belongs_to :notified_by, class_name: 'User'
  belongs_to :article
  
  validates :user_id, :notified_by_id, :article_id, :identifier, :notice_type, presence: true

    def user
      User.unscoped { super }
    end
    def notified_by
      User.unscoped { super }
    end

end
