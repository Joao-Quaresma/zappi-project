class NotificationsController < ApplicationController
  
  
  
  def read_all
    current_user.notifications.where(read: false).update_all(read: true)
    redirect_to notifications_path
  end
  
  def link_through
    @notification = Notification.find(params[:id])
    @notification.update read: true
    redirect_to socialpost_path @notification.socialpost
  end
  
  
  def index
    @notifications = current_user.notifications.where(read: false).order('created_at DESC').paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.js
      format.html
    end
  end
  
  def index_all_read
    @notifications = current_user.notifications.where(read: true).order('created_at DESC').paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.js
      format.html
    end
  end
  

end

