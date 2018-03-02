class Socialpost < ActiveRecord::Base
    belongs_to :user
    has_many :comments, dependent: :destroy
    
    
    validates :user_id, presence: true
    #enable this validates bellow if we want to obligate the user to upload an image in every post
    validates :caption, presence: true
    #validates :image, presence: true
    has_attached_file :image, styles: { :medium => "640x" }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
    
    
end
