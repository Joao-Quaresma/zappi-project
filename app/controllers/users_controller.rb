class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :user_socialposts_search, :user_announcements_search, :user_articles_search, :user_faqs_search, :user_follow_articles, :user_follow_announcements, :user_follow_faqs, :to_do_list]
  before_action :require_same_user, only: [:edit, :update]
  before_action :require_admin, only: [:deleted_users_index, :destroy]

  #Get /users
  #Get /users/users.json
  def index
    @users = User.all.paginate(page: params[:page], per_page: 40).order('username ASC')
  end

  def deleted_users_index
    @users = User.only_deleted.paginate(page: params[:page], per_page: 40).order('username ASC')
  end

  
  def edit
  end
  
  def update
    if params[:user][:password].blank? #will allow the admin to update the user without entering a password
      params[:user].delete(:password)
    end
    if @user.update(user_params)
      flash[:success] = "Account updated successfully"
      redirect_to user_path(@user)
    else
      render 'edit'
    end
  end

  def show
    @categories = @user.following_by_type('Category').order('name ASC')
    if !User.with_deleted.find_by_username(params[:id])
      flash[:error] = "Invalid user"
      redirect_to users_path
    end
  end

  def destroy
      @user.destroy
      redirect_to users_path, notice: "User has been deleted."
  end

  
  def search
    if params[:search_param].blank?
      flash.now[:danger] = "You have entered an empty search string"
    else
      @user = User.search(params[:search_param])
      flash.now[:danger] = "No users match this search criteria" if @user.blank?
    end
    render partial: 'users/result'
  end
  
  def user_socialposts_search
    @user_socialposts = @user.socialposts.all.order('updated_at DESC').paginate(page: params[:page],per_page: 12)
  end
  
  def user_announcements_search
    @user_announcements = @user.announcements.order('updated_at DESC').paginate(page: params[:page],per_page: 21)
  end
  
  def user_articles_search
    @user_articles = @user.articles.order('updated_at DESC').paginate(page: params[:page],per_page: 21)
  end

  def user_faqs_search
    @user_faqs = @user.faqs.order('updated_at DESC').paginate(page: params[:page],per_page: 21)
  end

  def user_follow_articles
    @articles = @user.following_by_type('Article')
  end

  def user_follow_announcements
    @announcements = @user.following_by_type('Announcement')
  end

  def user_follow_faqs
   @faqs = @user.following_by_type('Faq')
  end


  def to_do_list
    @articles = Article.order(:position)
  end

  
  private
  def user_params
    params.require(:user).permit(:username,:password, :first_name, :last_name, :email, :admin, :avatar, :resume, :role, :job_role)
  end
  def set_user
    if @user = User.with_deleted.find_by_username(params[:id])
    else
      flash[:error] = "Invalid user"
      redirect_to users_path
    end
  end
  def require_same_user
    unless current_user == @user || current_user.admin?
      flash[:danger] = "You can only edit your own account!"
      redirect_to users_path
    end
  end
  def require_admin
    unless current_user.admin?
      flash[:danger] = "No access!"
      redirect_to users_path
    end
  end


end