class FollowsAnnouncementsController < FollowsController

  def followable
    @followable ||= Announcement.find(params[:announcement_id])
  end

end


