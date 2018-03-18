class AnnouncementnotificationsController < ApplicationController
  def read_all
    current_user.announcementnotifications.where(read: false).update_all(read: true)
    redirect_to announcementnotifications_path
  end
  
    def link_announcementthrough
      @announcementnotification = Announcementnotification.find(params[:id])
      @announcementnotification.update read: true
      redirect_to announcement_path @announcementnotification.announcement
    end
  
  
  def index
    @announcementnotifications = current_user.announcementnotifications.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end
  
  def index_all_read
    @announcementnotifications = current_user.announcementnotifications.order('created_at DESC').paginate(page: params[:page], per_page: 10)
  end   
    
end
