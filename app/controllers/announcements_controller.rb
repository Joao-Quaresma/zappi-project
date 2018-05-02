class AnnouncementsController < ApplicationController
    before_action :set_announcement, only: [:edit, :update, :show, :destroy, :require_same_user, :create_announcement_bookmark, :destroy_announcement_bookmark]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    after_action :notified_users, only: [:create, :update]
  
  def index
    @announcements = Announcement.all.order("updated_at DESC").paginate(page: params[:page], per_page: 21)
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
          if @announcement.categories.any? do |category|
              create_notification @announcement, category
            end
          end
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
    @users = User.all.order('username ASC')
  end
  
  def destroy
    @announcement.destroy
    flash[:danger] = "Announcement was successfully deleted"
    redirect_to announcements_path
  end


  def announcements_bookmark_list
    @user = User.with_deleted.find_by_username(params[:id])
    @announcements = Announcement.order(:position)
  end

  def sort 
    params[:announcement].each_with_index do |id, index|
        Announcement.where(id: id).update_all(position: index + 1)
      end 
    head :ok
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
  
  def mentions
    @mentions ||= begin
                    regex = /@([\w]+)/
                    @announcement.body.scan(regex).flatten
                  end
  end
  
  def mentioned_users
    @mentioned_users ||= User.where(username: mentions)
  end
  
  def notified_users
      mentioned_users.each do |user|
          return if user.id == current_user.id 
          Announcementnotification.create(user_id: user.id,
                      notified_by_id: current_user.id,
                      announcement_id: @announcement.id,
  		                  identifier: @announcement.id,
                      notice_type: 'tagged')
      end
  end

  def create_announcement_bookmark
    if current_user.bookmark(@announcement)
      flash[:success] = "Announcement added to the To Do List"
      redirect_to :back
    end
  end

  def destroy_announcement_bookmark
    if current_user.unbookmark(@announcement)
      flash[:alert] = "Announcement removed from the To Do List"
      redirect_to :back
    end
  end
  
  private
    def set_announcement
      @announcement = Announcement.find(params[:id])
    end
    
    def announcement_params
      params.require(:announcement).permit(:title, :description, :body, category_ids: [])
    end

    def require_same_user
      unless current_user == @announcement.user || current_user.admin?
        flash[:danger] = "You can only delete your Announcements"
        redirect_to announcements_path
      end
    end

    def create_notification(announcement, category)
      @users = User.all.where("id != ?", current_user.id)
      @users.each do |user|
        if user.following?(category)
          Announcementnotification.create(user_id: user.id,
                            notified_by_id: current_user.id,
                            announcement_id: @announcement.id,
                            identifier: @announcement.id,
                            notice_type: 'New Announcement')
        end
      end
    end
  
end

