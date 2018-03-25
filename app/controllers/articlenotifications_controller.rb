class ArticlenotificationsController < ApplicationController
  def read_all
    current_user.articlenotifications.where(read: false).update_all(read: true)
    redirect_to articlenotifications_path
  end
  
    def link_articlethrough
      @articlenotification = Articlenotification.find(params[:id])
      @articlenotification.update read: true
      redirect_to article_path @articlenotification.article
    end
  
  
  def index
    @articlenotifications = current_user.articlenotifications.where(read: false).order('created_at DESC').paginate(page: params[:page], per_page: 20)
  end
  
  def index_all_read
    @articlenotifications = current_user.articlenotifications.where(read: true).order('created_at DESC').paginate(page: params[:page], per_page: 20)
  end   
    
end
