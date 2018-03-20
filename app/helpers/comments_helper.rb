module CommentsHelper
    def linked_users_comment(content)
      content.gsub(/@([\w]+)/) do |match|
          link_to match, user_path($1)
      end.html_safe  
    end
end
