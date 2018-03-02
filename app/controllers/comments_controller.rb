class CommentsController < ApplicationController
    before_action :set_socialpost
    before_action :authenticate_user!



    def create
      @comment = @socialpost.comments.build(comment_params)
      @comment.user_id = current_user.id
      if @comment.save
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
    
  

    
    private
    def comment_params
      params.require(:comment).permit(:content)
    end
    
    def set_socialpost
      @socialpost = Socialpost.find(params[:socialpost_id])
    end
    
end
