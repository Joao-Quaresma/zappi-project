class CategoriesController < ApplicationController
 before_action :authenticate_user!
 before_action :require_admin, only: [:destroy]
 before_action :set_category, only: [:edit, :update,:show,:destroy,:category_articles_search, :category_announcements_search]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 100).order('name ASC')
  end
  
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:success] = "Category created successfully"
      redirect_to categories_path
    else
      render 'new'
    end
  end
  
   def edit
   end
  

  def update
    if @category.update(category_params)
      flash[:success] = "Category name was successfully updated"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end


  def show
  end
  
  def destroy
    @category.destroy
    flash[:danger] = "Category was successfully deleted"
    redirect_to categories_path
  end
  
  
  def search
    if params[:search_param].blank?
      flash.now[:danger] = "You have entered an empty search string"
    else
      @category = Category.search(params[:search_param])
      flash.now[:danger] = "No categories match this search criteria" if @category.blank?
    end
    render partial: 'categories/result'
  end
  
  def category_articles_search
    #will paginate the posts in the category articles filter
    @category_articles = @category.articles.order("created_at DESC").paginate(page: params[:page], per_page: 20)
    @category_announcements = @category.announcements.order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end
  def category_announcements_search
    #will paginate the posts in the category announcements filter
    @category_announcements = @category.announcements.order("created_at DESC").paginate(page: params[:page], per_page: 20)
  end

  
  private
  def category_params
    params.require(:category).permit(:name)
  end
  
  def set_category
    @category = Category.find(params[:id])
  end
  
# Only admins can delete categories 
  def require_admin
   if !current_user.admin?
      flash[:danger] = "Only an Admin can perform that action"
      redirect_to categories_path
   end
  end
end

