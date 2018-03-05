class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show,:editlogin, :edit, :update]
  before_action :require_same_user, only: [:edit, :editlogin, :update]

  
  
  def index
    @users = User.paginate(page: params[:page], per_page: 5)
  end
  
  def edit
  end
  
  def editlogin
  end
  
  def update
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
    @socialposts = @user.socialposts.order('created_at DESC')
  end

  
  private
  def user_params
    params.require(:user).permit(:password, :username, :first_name, :last_name, :email, :admin, :avatar, :resume, :role)
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