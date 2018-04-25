class FaqCommentsController < ApplicationController
    before_action :set_faq
    before_action :set_faq_comment, only: [:update, :edit, :show, :destroy]
    before_action :same_user, only: [:edit, :update, :show, :destroy]
    after_action :notified_users, only: [:create, :update]
    
    
    def create
        @faq_comment = @faq.faq_comments.create(params[:faq_comment].permit(:body))
        @faq_comment.user_id = current_user.id if current_user
        if @faq_comment.save
            create_notification @faq, @faq_comment
            redirect_to faq_path(@faq), notice: "Your comment has been saved."
        else
            flash[:alert] = "Check the comment form, something went wrong."
            redirect_to :back
        end
    end
    
    def update
        if @faq_comment.update(params[:faq_comment].permit(:body))
            redirect_to faq_path(@faq), notice: "Your comment has been updated."
        else
            render 'edit'
        end
    end

    def edit
    end
    
    def show
    end
    
    def mentions
        @mentions ||= begin
                        regex = /@([\w]+)/
                        @faq_comment.body.scan(regex).flatten
                      end
    end
    
    def mentioned_users
        @mentioned_users ||= User.where(username: mentions)
    end
    
    def notified_users
        mentioned_users.each do |user|
            return if user.id == current_user.id 
            Faqnotification.create(user_id: user.id,
                        notified_by_id: current_user.id,
                        faq_id: @faq.id,
                          identifier: @faq_comment.id,
                        notice_type: 'tagged')
        end
    end

    
    def destroy
        @faq_comment.destroy
        redirect_to faq_path(@faq), notice: "Comment has been deleted."
    end
    
    private
    def set_faq
        @faq = Faq.find(params[:faq_id])
    end
    def set_article_comment
        @faq_comment = @faq.faq_comments.find(params[:id])
    end
    def same_user
        unless current_user.id == @article_comment.user_id || current_user.admin?
            flash[:danger] = "You can only delete your comments"
            redirect_to faq_path(@faq)
        end 
    end
    
    def create_notification(faq, faq_comment)
      return if faq.user.id == current_user.id 
      Faqnotification.create(user_id: faq.user.id,
                        notified_by_id: current_user.id,
                        faq_id: faq.id,
                        identifier: @faq_comment.id,
                        notice_type: 'comment')
    end  
end