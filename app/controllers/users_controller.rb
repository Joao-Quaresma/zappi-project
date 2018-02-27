class UsersController < ApplicationController
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      flash[:success] = "Account updated successfully"
      redirect_to user_path
    else
      render 'edit'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end

#this destroy is used in the User views
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:danger] = "User and all articles created by the user have been deleted"
    redirect_to users_path
  end
  
  private
  def user_params
    params.require(:user).permit(:username, :email, :admin)
  end
  
end
