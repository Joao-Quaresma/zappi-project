class SocialpostsController < ApplicationController
    before_action :set_socialpost, only: [:show, :edit, :update, :destroy, :like, :unlike]
    before_action :owned_socialpost, only: [:edit, :update, :destroy]
    after_action :notified_users, only: [:create, :update]
    
    def index
        @socialposts = Socialpost.all.order('updated_at DESC').paginate(page: params[:page],per_page: 12)
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
            create_notification @socialpost, @comment
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
  

    def search
        if params[:search_param].blank?
            flash.now[:danger] = "You have entered an empty search string"
        else
          @socialpost = Socialpost.order('updated_at DESC').search(params[:search_param])
          flash.now[:danger] = "No Social Posts match this search criteria" if @socialpost.blank?
        end
        render partial: 'socialposts/result'
    end
    
    
    def mentions
        @mentions ||= begin
                        regex = /@([\w]+)/
                        @socialpost.caption.scan(regex).flatten
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
    		                  identifier: @socialpost.id,
                        notice_type: 'tagged')
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
    
    def create_notification(socialpost, comment)
    	return if socialpost.user.id == current_user.id 
      Notification.create(user_id: socialpost.user.id,
                        notified_by_id: current_user.id,
                        socialpost_id: socialpost.id,
			            identifier: socialpost.id,
                        notice_type: 'like')
    end

end
