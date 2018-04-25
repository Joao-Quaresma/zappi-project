class FaqCategory < ActiveRecord::Base
	belongs_to :faq
 	belongs_to :category
end
