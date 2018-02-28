class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update(user_params)
      flash[:success] = "Account updated successfully"
      redirect_to user_path
    else
      render 'edit'
    end
  end
  
  def show
  end

#this destroy is used in the User views
  def destroy
    @user.destroy
    flash[:danger] = "User and all articles created by the user have been deleted"
    redirect_to users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :admin, :password)
  end
  def set_user
    @user = User.find(params[:id])
  end

  
end
