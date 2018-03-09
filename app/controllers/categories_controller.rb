class CategoriesController < ApplicationController
 before_action :authenticate_user!
 before_action :require_admin, only: [:destroy]
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 20).order('name ASC')
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
     @category = Category.find(params[:id])
   end
  

  def update
    @category = Category.find(params[:id])
    if @category.update(category_params)
      flash[:success] = "Category name was successfully updated"
      redirect_to category_path(@category)
    else
      render 'edit'
    end
  end


  def show
    @category = Category.find(params[:id])
    #will paginate the posts in the category filter
    @category_articles = @category.articles.paginate(page: params[:page], per_page: 20)
  end
  
  def destroy
    @category = Category.find(params[:id])
    @category.destroy
    flash[:danger] = "Category was successfully deleted"
    redirect_to categories_path
  end
  
  private
  def category_params
    params.require(:category).permit(:name)
  end
  
  
# Only admins can delete categories 
  def require_admin
   if !current_user.admin?
      flash[:danger] = "Only an Admin can perform that action"
      redirect_to categories_path
   end
  end
end

