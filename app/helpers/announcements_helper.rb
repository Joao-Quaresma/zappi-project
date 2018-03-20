module AnnouncementsHelper
  def linked_users_announcement(body)
      body.gsub(/@([\w]+)/) do |match|
          link_to match, user_path($1)
      end.html_safe
  end
  def linked_users_announcement(description)
      description.gsub(/@([\w]+)/) do |match|
          link_to match, user_path($1)
      end.html_safe
  end
end
