class FollowsController < ApplicationController

  def create
		if current_user.follow(followable)
		respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def destroy
    	if current_user.stop_following(followable)
    		respond_to do |format|
        format.html
        format.js
      end
    end
  end

end