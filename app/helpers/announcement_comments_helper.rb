module AnnouncementCommentsHelper
  def linked_users_announcement_comment(body)
      body.gsub(/@([\w]+)/) do |match|
          link_to match, user_path($1)
      end.html_safe
  end
end
