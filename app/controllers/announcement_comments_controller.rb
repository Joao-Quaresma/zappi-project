class AnnouncementCommentsController < ApplicationController
    before_action :set_announcement
    before_action :set_announcement_comment, only: [:update, :edit, :destroy]
    before_action :same_user, only: [:destroy]
    after_action :notified_users, only: [:create, :update]
    
    
    
    def create
        @announcement_comment = @announcement.announcement_comments.create(params[:announcement_comment].permit(:body))
        @announcement_comment.user_id = current_user.id if current_user
        if @announcement_comment.save
            create_notification @announcement, @announcement_comment
            redirect_to announcement_path(@announcement), notice: "Your comment has been saved."
        else
            flash[:alert] = "Check the comment form, something went wrong."
            redirect_to :back
        end
    end
    
    def update
        if @announcement_comment.update(params[:announcement_comment].permit(:body))
            redirect_to announcement_path(@announcement), notice: "Your comment has been updated."
        else
            render 'edit'
        end
    end

    def edit
    end
    
    def destroy
        @announcement_comment.destroy
        redirect_to announcement_path(@announcement), notice: "Comment has been deleted."
    end
    
    def mentions
        @mentions ||= begin
                        regex = /@([\w]+)/
                        @announcement_comment.body.scan(regex).flatten
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
    		                  identifier: @announcement_comment.id,
                        notice_type: 'tagged')
        end
    end
    
    private
    def set_announcement
        @announcement = Announcement.find(params[:announcement_id])
    end
    def set_announcement_comment
        @announcement_comment = @announcement.announcement_comments.find(params[:id])
    end
    def same_user
       if !current_user.admin? && current_user.id != @announcement_comment.user_id
        flash[:danger] = "You can only delete your comments"
        redirect_to announcement_path(@announcement)
       end 
    end
    
    def create_notification(announcement, announcement_comment)
    	return if announcement.user.id == current_user.id 
      Announcementnotification.create(user_id: announcement.user.id,
                        notified_by_id: current_user.id,
                        announcement_id: announcement.id,
			                  identifier: @announcement_comment.id,
                        notice_type: 'comment')
    end
end