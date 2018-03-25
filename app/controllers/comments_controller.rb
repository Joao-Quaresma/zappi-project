class CommentsController < ApplicationController
    before_action :set_socialpost
    after_action :notified_users, only: [:create, :update]

    def create
      @comment = @socialpost.comments.build(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        create_notification @socialpost, @comment
        respond_to do |format|
          format.html { redirect_to root_path }
          format.js
        end
      else
        flash[:alert] = "Check the comment form, something went wrong."
        redirect_to :back
      end
    end
    
    def show
    end
    
    def destroy
      @comment = @socialpost.comments.find(params[:id])
      if current_user.admin? || current_user.id == @comment.user_id
        @comment.delete
        respond_to do |format|
          format.html { redirect_to root_path }
          format.js
        end
      end
    end
    
      def index
        @comments = @socialpost.comments
        respond_to do |format|
          format.html { render layout: !request.xhr? }
        end
      end
      
    def mentions
        @mentions ||= begin
                        regex = /@([\w]+)/
                        @comment.content.scan(regex).flatten
                      end
    end
    
    def mentioned_users
        @mentioned_users ||= User.where(username: mentions)
    end
    
    def notified_users
        mentioned_users.each do |user|
            return if user.id == current_user.id 
            Notification.create(user_id: user.id,
                        notified_by_id: current_user.id,
                        socialpost_id: @socialpost.id,
    		                  identifier: @comment.id,
                        notice_type: 'tagged')
        end
    end
  

    
    private
    def comment_params
      params.require(:comment).permit(:content)
    end
    
    def set_socialpost
      @socialpost = Socialpost.find(params[:socialpost_id])
    end
    
    def create_notification(socialpost, comment)
    	return if socialpost.user.id == current_user.id 
      Notification.create(user_id: socialpost.user.id,
                        notified_by_id: current_user.id,
                        socialpost_id: socialpost.id,
			                  identifier: @comment.id,
                        notice_type: 'comment')
    end
    
    
    
    
end
