module FaqsHelper
  def linked_users_faq(body)
      body.gsub(/@([\w]+)/) do |match|
          link_to match, user_path($1)
      end.html_safe  
  end
  def linked_users_faq(description)
      description.gsub(/@([\w]+)/) do |match|
          link_to match, user_path($1)
      end.html_safe
  end

end
