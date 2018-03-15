class Socialpost < ActiveRecord::Base
    acts_as_votable
    
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_many :notifications, dependent: :destroy
    
    validates :user_id, presence: true
    #enable this validates bellow if we want to obligate the user to upload an image in every post
    validates :caption, presence: true, length: { minimum: 1, maximum: 500 }
    #validates :image, presence: true
    has_attached_file :image, styles: { :medium => "640x" }
    validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/

    
    
    def self.search(param)
      param.strip!
      param.downcase!
      to_send_back = (caption_matches(param)).uniq
      return nil unless to_send_back
      to_send_back
    end
    
    def self.caption_matches(param)
      matches('caption', param)
    end

    
    def self.matches(field_name, param)
      Socialpost.where("#{field_name} like ?", "%#{param}%")
    end
    
end
