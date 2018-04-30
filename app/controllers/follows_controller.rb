class FollowsController < ApplicationController

  def create
		if current_user.follow(followable)
      flash[:success] = "You are now following this content!"
  		redirect_to :back
    end
  end

  def destroy
    if current_user.stop_following(followable)
      flash[:alert] = "You stopped following this content!"
      redirect_to :back
    end
  end

end