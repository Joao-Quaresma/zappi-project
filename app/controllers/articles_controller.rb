class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy, :require_same_user, :create_article_bookmark, :destroy_article_bookmark]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    after_action :notified_users, only: [:create, :update]
  
  def index
    @articles = Article.all.order("updated_at DESC").paginate(page: params[:page], per_page: 21)
  end
  
 
  def new
    @article = Article.new
  end
  
  def edit
  end
  
  
    def create
        @article = Article.new(article_params)
        @article.user = current_user
        if @article.save
          if @article.categories.any? do |category|
              create_notification @article, category
            end
          end
          flash[:success] = "Post was successfully created"
          redirect_to article_path(@article)
        else
          render 'new'
        end
    end
  
  
  def update
    if @article.update(article_params)
      flash[:success] = "Post was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end
  
  def show
    @users = User.all.order('username ASC')
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Post was successfully deleted"
    redirect_to articles_path
  end



  def articles_bookmark_list
    @user = User.with_deleted.find_by_username(params[:id])
    @articles = Article.order(:position)
  end

  def sort 
    params[:article].each_with_index do |id, index|
        Article.where(id: id).update_all(position: index + 1)
      end 
    head :ok
  end
  
  def search
    if params[:search_param].blank?
      flash.now[:danger] = "You have entered an empty search string"
    else
      @article = Article.search(params[:search_param])
      flash.now[:danger] = "No article match this search criteria" if @article.blank?
    end
    render partial: 'articles/result'
  end
  
  
  def mentions
    @mentions ||= begin
                    regex = /@([\w]+)/
                    @article.description.scan(regex).flatten
                    @article.body.scan(regex).flatten
                  end
  end
  
  def mentioned_users
    @mentioned_users ||= User.where(username: mentions)
  end
  
  def notified_users
      mentioned_users.each do |user|
          return if user.id == current_user.id 
          Articlenotification.create(user_id: user.id,
                      notified_by_id: current_user.id,
                      article_id: @article.id,
  		                  identifier: @article.id,
                      notice_type: 'tagged')
      end
  end
  
  def create_article_bookmark
    if current_user.bookmark(@article)
      flash[:success] = "Article added to the To Do List"
      redirect_to :back
    end
  end

  def destroy_article_bookmark
    if current_user.unbookmark(@article)
      flash[:alert] = "Article removed from the To Do List"
      redirect_to :back
    end
  end

  
  private
    def set_article
      @article = Article.find(params[:id])
    end
    
    def article_params
    params.require(:article).permit(:title, :description, :body, category_ids: [])
    end

    def require_same_user
      unless current_user == @article.user || current_user.admin?
        flash[:danger] = "You can only delete your Posts"
        redirect_to articles_path
      end
    end

    def create_notification(article, category)
      @users = User.all.where("id != ?", current_user.id)
      @users.each do |user|
        if user.following?(category)
          Articlenotification.create(user_id: user.id,
                            notified_by_id: current_user.id,
                            article_id: @article.id,
                            identifier: @article.id,
                            notice_type: 'New Wiki')
        end
      end
    end
  
end

