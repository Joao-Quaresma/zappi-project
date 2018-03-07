class SocialpostsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_socialpost, only: [:show, :edit, :update, :destroy, :like, :unlike]
    before_action :owned_socialpost, only: [:edit, :update, :destroy]

    
    def index
        @socialposts = Socialpost.order('created_at DESC').paginate(page: params[:page],per_page: 3)
    end
    
    def new
        @socialpost = current_user.socialposts.build
    end  
    
    def create
        @socialpost = current_user.socialposts.build(socialpost_params)
        if @socialpost.save
            flash[:success] = "Your post has been created!"
            redirect_to socialposts_path
        else
            flash.now[:alert] = "Your new post couldn't be created!  Please check the form."
        render :new
        end
    end
    

    def show
        
    end     
    
    def edit
        
    end
    
    def update
        if @socialpost.update(socialpost_params)
            flash[:success] = "Post updated."
            redirect_to(socialpost_path(@socialpost))
        else
            flash.now[:alert] = "Update failed.  Please check the form."
            render :edit
        end
    end
    
    def destroy
        @socialpost.destroy
        flash[:success] = "Post deleted"
        redirect_to socialposts_path
    end
    
    def like
        if @socialpost.liked_by current_user
          respond_to do |format|
            format.html { redirect_to :back }
            format.js
          end
        end
    end
        
    def unlike
        if @socialpost.unliked_by current_user
          respond_to do |format|
            format.js
            format.html { redirect_to :back }
          end
        end
    end
  
    
    
    private
    def socialpost_params
        params.require(:socialpost).permit(:image, :caption)
    end
    def set_socialpost
        @socialpost = Socialpost.find(params[:id])
    end
    def owned_socialpost
        unless current_user == @socialpost.user || current_user.admin?
        flash[:alert] = "Error! You can't edit posts from other users."
        redirect_to socialpost_path(@socialpost)
        end
    end

end