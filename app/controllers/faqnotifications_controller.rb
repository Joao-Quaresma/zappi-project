class FaqnotificationsController < ApplicationController
  def read_all
    current_user.faqnotifications.where(read: false).update_all(read: true)
    redirect_to faqnotifications_path
  end
  
    def link_faqthrough
      @faqnotification = Faqnotification.find(params[:id])
      @faqnotification.update read: true
      redirect_to faq_path @faqnotification.faq
    end
  
  
  def index
    @faqnotifications = current_user.faqnotifications.where(read: false).order('created_at DESC').paginate(page: params[:page], per_page: 20)
  end
  
  def index_all_read
    @faqnotifications = current_user.faqnotifications.where(read: true).order('created_at DESC').paginate(page: params[:page], per_page: 20)
  end   
    
end
