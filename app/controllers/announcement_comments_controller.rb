class AnnouncementCommentsController < ApplicationController
    before_action :set_announcement
    before_action :set_announcement_comment, only: [:update, :edit, :destroy]
    before_action :same_user, only: [:destroy]
    
    
    
    def create
        @announcement_comment = @announcement.announcement_comments.create(params[:announcement_comment].permit(:body))
        @announcement_comment.user_id = current_user.id if current_user
        if @announcement_comment.save
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
end