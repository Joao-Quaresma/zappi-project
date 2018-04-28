class ArticleCommentsController < ApplicationController
    before_action :set_article
    before_action :set_article_comment, only: [:update, :edit, :show, :destroy]
    before_action :same_user, only: [:edit, :update, :show, :destroy]
    after_action :notified_users, only: [:create, :update]
    
    
    def create
        @article_comment = @article.article_comments.create(params[:article_comment].permit(:body))
        @article_comment.user_id = current_user.id if current_user
        if @article_comment.save
            create_notification @article, @article_comment
            create_comment_notification @article, @article_comment
            redirect_to article_path(@article), notice: "Your comment has been saved."
        else
            flash[:alert] = "Check the comment form, something went wrong."
            redirect_to :back
        end
    end
    
    def update
        if @article_comment.update(params[:article_comment].permit(:body))
            redirect_to article_path(@article), notice: "Your comment has been updated."
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
                        @article_comment.body.scan(regex).flatten
                      end
    end
    
    def mentioned_users
        @mentioned_users ||= User.where(username: mentions)
    end
    
    def notified_users
        mentioned_users.each do |user|
            return if user.id == current_user.id 
            Articlenotification.create(user_id: user.id,
                        notified_by_id: current_user.id,
                        article_id: @article.id,
    		                  identifier: @article_comment.id,
                        notice_type: 'tagged')
        end
    end

    
    def destroy
        @article_comment.destroy
        redirect_to article_path(@article), notice: "Comment has been deleted."
    end
    
    private
    def set_article
        @article = Article.find(params[:article_id])
    end
    def set_article_comment
        @article_comment = @article.article_comments.find(params[:id])
    end
    def same_user
        unless current_user.id == @article_comment.user_id || current_user.admin?
            flash[:danger] = "You can only delete your comments"
            redirect_to article_path(@article)
        end 
    end
    
    def create_notification(article, article_comment)
    	return if article.user.id == current_user.id 
      Articlenotification.create(user_id: article.user.id,
                        notified_by_id: current_user.id,
                        article_id: article.id,
			                  identifier: @article_comment.id,
                        notice_type: 'comment')
    end

    def create_comment_notification(article, article_comment)
      @users = User.all.where("id != ?", current_user.id)
      @users.each do |user|
        if user.following?(article)
          Articlenotification.create(user_id: user.id,
                            notified_by_id: current_user.id,
                            article_id: @article.id,
                            identifier: @article_comment.id,
                            notice_type: 'New Comment')
        end
      end
    end
    
    
end