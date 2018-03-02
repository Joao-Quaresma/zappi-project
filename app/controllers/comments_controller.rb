class CommentsController < ApplicationController
    before_action :set_socialpost
    before_action :authenticate_user!



    def create
      @comment = @socialpost.comments.build(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
        flash[:success] = "Your comment saved with success!"
        redirect_to :back
      else
        flash[:alert] = "Check the comment form, something went wrong."
        redirect_to :back
      end
    end
    
    def show
    end
    
    def destroy
        @comment = @socialpost.comments.find(params[:id])
        @comment.destroy
        flash[:success] = "Comment deleted"
        redirect_to :back
    end
    
    private
    def comment_params
      params.require(:comment).permit(:content)
    end
    
    def set_socialpost
      @socialpost = Socialpost.find(params[:socialpost_id])
    end
    
end
