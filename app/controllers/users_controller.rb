class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :editlogin, :edit, :update]
  before_action :require_same_user, only: [:edit, :editlogin, :update]

  
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
  end
  
  def editlogin
  end
  
  def update
    if params[:user][:password].blank? #will allow the admin to update the user without entering a password
      params[:user].delete(:password)
    end
    if @user.update(user_params)
      flash[:success] = "Account updated successfully"
      redirect_to user_path(@user.id)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render 'editlogin'
    end
  end
  
  
  def show
    @socialposts = @user.socialposts.order('created_at DESC').paginate(page: params[:page],per_page: 12)
       respond_to do |format|
          format.js
          format.html
        end
  end

  
  private
  def user_params
    params.require(:user).permit(:username,:password, :first_name, :last_name, :email, :admin, :avatar, :resume, :role, :job_role)
  end
  def set_user
    @user = User.find(params[:id])
  end
  def require_same_user
    unless current_user == @user || current_user.admin?
      flash[:danger] = "You can only edit your own account!"
      redirect_to users_path
    end
  end


  
end