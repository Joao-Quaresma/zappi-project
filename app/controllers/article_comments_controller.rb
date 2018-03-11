class ArticleCommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_article
    before_action :set_article_comment, only: [:update, :edit, :destroy]
    before_action :same_user, only: [:destroy]
    
    
    
    def create
        @article_comment = @article.article_comments.create(params[:article_comment].permit(:body))
        @article_comment.user_id = current_user.id if current_user
        if @article_comment.save
            redirect_to article_path(@article), notice: "Your comment has been saved."
        else
            redirect_to 'new'
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
    
    def destroy
        @article_comment.destroy
        redirect_to article_path(@article), notice: "Your comment has been deleted."
    end
    
    private
    def set_article
        @article = Article.find(params[:article_id])
    end
    def set_article_comment
        @article_comment = @article.article_comments.find(params[:id])
    end
    def same_user
       if current_user != @article_comment.user || !current_user.admin?
        flash[:danger] = "You can only delete your comments"
        redirect_to root_path
       end 
    end
end