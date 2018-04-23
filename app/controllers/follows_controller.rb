class FollowsController < ApplicationController

  def create
    @category = Category.find(params[:category_id])
		if current_user.follow(@category)
		respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

  def destroy
    @category = Category.find(params[:category_id])
    	if current_user.stop_following(@category)
    		respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end

end