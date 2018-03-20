class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :require_same_user, only: [:destroy]
    
    after_action :notified_users, only: [:create, :update]
  
  def index
    @articles = Article.all.order("updated_at DESC").paginate(page: params[:page], per_page: 20)
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
  end
  
  def destroy
    @article.destroy
    flash[:danger] = "Post was successfully deleted"
    redirect_to articles_path
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
      Mail.new(user)
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
      if current_user != @article.user || !current_user.admin?
        flash[:danger] = "You can only delete your Posts"
        redirect_to root_path
      end
    end
  
end

