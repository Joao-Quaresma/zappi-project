class AnnouncementsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_announcement, only: [:edit, :update, :show, :destroy]
    before_action :require_same_user, only: [:destroy]
  
  def index
    @announcements = Announcement.order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end
  
 
  def new
    @announcement = Announcement.new
  end
  
  def edit
  end
  
  
    def create
        @announcement = Announcement.new(announcement_params)
        @announcement.user = current_user
        if @announcement.save
          flash[:success] = "Announcement was successfully created"
          redirect_to announcement_path(@announcement)
        else
          render 'new'
        end
    end
  
  
  def update
    if @announcement.update(announcement_params)
      flash[:success] = "Announcement was successfully updated"
      redirect_to announcement_path(@announcement)
    else
      render 'edit'
    end
  end
  
  def show
  end
  
  def destroy
    @announcement.destroy
    flash[:danger] = "Announcement was successfully deleted"
    redirect_to announcements_path
  end
  
  def search
    if params[:search_param].blank?
      flash.now[:danger] = "You have entered an empty search string"
    else
      @announcement = Announcement.search(params[:search_param])
      flash.now[:danger] = "No announcements match this search criteria" if @announcement.blank?
    end
    render partial: 'announcements/result'
  end
  
  
  private
    def set_announcement
    @announcement = Announcement.find(params[:id])
    end
    
    def announcement_params
    params.require(:announcement).permit(:title, :description, :body, category_ids: [])
    end

    def require_same_user
      if current_user != @announcement.user || !current_user.admin?
        flash[:danger] = "You can only delete your Announcements"
        redirect_to root_path
      end
    end
  
end
